const fs = require('fs');
const path = require('path');

/**
 * State Graph Generator for Public License Selector
 *
 * Parses src/data/questions.coffee and generates Mermaid flowcharts
 * showing the decision tree flow for both data and software licensing.
 */

class StateGraphGenerator {
  constructor() {
    this.states = {};
    this.transitions = [];
    this.terminalStates = [];
    this.errorStates = [];
  }

  /**
   * Parse the questions.coffee file and extract state information
   */
  parseQuestionsFile(filePath) {
    const content = fs.readFileSync(filePath, 'utf-8');

    // Extract each state function definition
    const stateFunctionRegex = /(\w+):\s*->\s*\n([\s\S]*?)(?=\n\s{2}\w+:|module\.exports|$)/g;
    let match;

    while ((match = stateFunctionRegex.exec(content)) !== null) {
      const stateName = match[1];
      const stateBody = match[2];

      this.parseState(stateName, stateBody);
    }
  }

  /**
   * Parse individual state function body
   */
  parseState(stateName, body) {
    const state = {
      name: stateName,
      question: null,
      answers: [],
      options: [],
      hasConditionalLogic: false
    };

    // Extract question text
    const questionMatch = body.match(/@question\s+['"]([^'"]+)['"]/);
    if (questionMatch) {
      state.question = questionMatch[1];
    }

    // Extract @answer calls
    const answerRegex = /@answer\s+['"]([^'"]+)['"],\s*->/g;
    let answerMatch;
    while ((answerMatch = answerRegex.exec(body)) !== null) {
      state.answers.push(answerMatch[1]);
    }

    // Extract @yes/@no calls (shorthand for answers)
    if (body.includes('@yes')) {
      state.answers.push('Yes');
    }
    if (body.includes('@no')) {
      state.answers.push('No');
    }

    // Extract @goto transitions
    const gotoRegex = /@goto\s+['"](\w+)['"]/g;
    let gotoMatch;
    while ((gotoMatch = gotoRegex.exec(body)) !== null) {
      this.transitions.push({
        from: stateName,
        to: gotoMatch[1],
        label: this.inferLabel(body, gotoMatch.index)
      });
    }

    // Check for @license (terminal state)
    if (body.includes('@license')) {
      this.terminalStates.push(stateName);
    }

    // Check for @cantlicense (error state)
    if (body.includes('@cantlicense')) {
      this.errorStates.push(stateName);
    }

    // Check for conditional logic
    if (body.includes('@only') || body.includes('@has') || body.includes('if ')) {
      state.hasConditionalLogic = true;
    }

    // Check for @option (multi-select)
    if (body.includes('@option')) {
      state.options.push('Multiple license selection');
    }

    this.states[stateName] = state;
  }

  /**
   * Infer the label for a transition based on context
   */
  inferLabel(body, gotoIndex) {
    // Look backwards from @goto to find the associated answer
    const beforeGoto = body.substring(0, gotoIndex);

    // Check for @yes -> @goto pattern
    if (beforeGoto.match(/@yes\s*->\s*$/)) {
      return 'Yes';
    }

    // Check for @no -> @goto pattern
    if (beforeGoto.match(/@no\s*->\s*$/)) {
      return 'No';
    }

    // Check for @answer 'text' -> @goto pattern
    const answerMatch = beforeGoto.match(/@answer\s+['"]([^'"]+)['"]\s*,\s*->\s*$/);
    if (answerMatch) {
      return answerMatch[1];
    }

    // Check for @option pattern
    if (beforeGoto.includes('@option')) {
      return 'Option selected';
    }

    return '';
  }

  /**
   * Generate Mermaid flowchart syntax
   */
  generateMermaid(options = {}) {
    const { filterPath = null, title = 'License Selector State Graph' } = options;

  let mermaid = `%%{init: {'theme':'base', 'themeVariables': { 'fontSize':'16px'}, 'flowchart':{'curve':'basis', 'padding':20}}}%%\n`;
  // Use TD (top-to-bottom) for all diagrams as requested
  mermaid += `flowchart TD\n`;
    mermaid += `    Start([Start]) --> KindOfContent\n\n`;

    // Generate nodes
    for (const [stateName, state] of Object.entries(this.states)) {
      if (filterPath && !this.isInPath(stateName, filterPath)) {
        continue;
      }

      const nodeShape = this.getNodeShape(stateName);
      const nodeText = state.question || stateName;
      const nodeClass = this.getNodeClass(stateName);

      mermaid += `    ${stateName}${nodeShape[0]}"${this.escapeText(nodeText)}"${nodeShape[1]}\n`;

      if (nodeClass) {
        mermaid += `    class ${stateName} ${nodeClass}\n`;
      }
    }

    mermaid += `\n`;

    // Generate transitions
    const processedTransitions = new Set();

    for (const transition of this.transitions) {
      if (filterPath && (!this.isInPath(transition.from, filterPath) || !this.isInPath(transition.to, filterPath))) {
        continue;
      }

      const transKey = `${transition.from}->${transition.to}`;
      if (processedTransitions.has(transKey)) {
        continue;
      }
      processedTransitions.add(transKey);

      const label = transition.label ? `|"${this.escapeText(transition.label)}"| ` : '';
      mermaid += `    ${transition.from} -->${label}${transition.to}\n`;
    }

    // Add terminal state transitions
    for (const termState of this.terminalStates) {
      if (filterPath && !this.isInPath(termState, filterPath)) {
        continue;
      }
      mermaid += `    ${termState} --> End([Select License])\n`;
    }

    for (const errorState of this.errorStates) {
      if (filterPath && !this.isInPath(errorState, filterPath)) {
        continue;
      }
      mermaid += `    ${errorState} --> Error([Cannot License])\n`;
    }

    // Add styling
    mermaid += `\n`;
    mermaid += `    classDef dataPath fill:#e1f5ff,stroke:#01579b,stroke-width:2px,padding:15px,min-width:250px\n`;
    mermaid += `    classDef softwarePath fill:#f3e5f5,stroke:#4a148c,stroke-width:2px,padding:15px,min-width:250px\n`;
    mermaid += `    classDef terminalNode fill:#c8e6c9,stroke:#2e7d32,stroke-width:3px,padding:15px\n`;
    mermaid += `    classDef errorNode fill:#ffcdd2,stroke:#c62828,stroke-width:3px,padding:15px\n`;

    return mermaid;
  }

  /**
   * Determine node shape based on state type
   */
  getNodeShape(stateName) {
    if (stateName === 'KindOfContent') {
      return ['{', '}'];  // Diamond for decision
    }
    if (this.terminalStates.includes(stateName)) {
      return ['([', '])'];  // Stadium for terminal
    }
    if (this.errorStates.includes(stateName)) {
      return ['([', '])'];  // Stadium for error
    }

    const state = this.states[stateName];
    if (state && state.answers.length === 2 &&
        (state.answers.includes('Yes') || state.answers.includes('No'))) {
      return ['{', '}'];  // Diamond for yes/no questions
    }

    return ['[', ']'];  // Rectangle for regular nodes
  }

  /**
   * Determine CSS class for node styling
   */
  getNodeClass(stateName) {
    const dataStates = [
      'DataCopyrightable', 'OwnIPR', 'AllowDerivativeWorks',
      'ShareAlike', 'CommercialUse', 'DecideAttribute',
      'EnsureLicensing', 'LicenseInteropData'
    ];

    const softwareStates = [
      'YourSoftware', 'LicenseInteropSoftware',
      'Copyleft', 'StrongCopyleft'
    ];

    if (dataStates.includes(stateName)) {
      return 'dataPath';
    }
    if (softwareStates.includes(stateName)) {
      return 'softwarePath';
    }
    if (this.terminalStates.includes(stateName)) {
      return 'terminalNode';
    }
    if (this.errorStates.includes(stateName)) {
      return 'errorNode';
    }

    return null;
  }

  /**
   * Check if a state is part of a specific path
   */
  isInPath(stateName, pathType) {
    const dataStates = [
      'KindOfContent', 'DataCopyrightable', 'OwnIPR', 'AllowDerivativeWorks',
      'ShareAlike', 'CommercialUse', 'DecideAttribute',
      'EnsureLicensing', 'LicenseInteropData'
    ];

    const softwareStates = [
      'KindOfContent', 'YourSoftware', 'LicenseInteropSoftware',
      'Copyleft', 'StrongCopyleft'
    ];

    if (pathType === 'data') {
      return dataStates.includes(stateName) ||
             this.terminalStates.includes(stateName) ||
             this.errorStates.includes(stateName);
    }
    if (pathType === 'software') {
      return softwareStates.includes(stateName) ||
             this.terminalStates.includes(stateName) ||
             this.errorStates.includes(stateName);
    }
    return true;
  }

  /**
   * Escape special characters for Mermaid and wrap long text
   * Uses actual newlines for proper GitHub Mermaid rendering
   */
  escapeText(text) {
    // Clean the text
    let cleaned = text
      .replace(/"/g, '\\"')  // Use escaped quotes for proper Mermaid rendering
      .replace(/\n/g, ' ')
      .trim();

    // Wrap text at ~45 characters for better readability on GitHub
    const maxLength = 45;
    if (cleaned.length <= maxLength) {
      return cleaned;
    }

    // Split into words and wrap
    const words = cleaned.split(' ');
    const lines = [];
    let currentLine = '';

    for (const word of words) {
      if ((currentLine + ' ' + word).length <= maxLength) {
        currentLine += (currentLine ? ' ' : '') + word;
      } else {
        if (currentLine) lines.push(currentLine);
        currentLine = word;
      }
    }
    if (currentLine) lines.push(currentLine);

    // Use actual newline character for GitHub Mermaid compatibility
    return lines.join('\n');
  }

  /**
   * Generate detailed state information table
   */
  generateStateTable() {
    let table = '| State | Question | Transitions | Type |\n';
    table += '|-------|----------|-------------|------|\n';

    for (const [stateName, state] of Object.entries(this.states)) {
      const question = state.question || stateName;
      const transitionsFrom = this.transitions
        .filter(t => t.from === stateName)
        .map(t => `→ ${t.to}`)
        .join('<br>');

      let type = 'Question';
      if (this.terminalStates.includes(stateName)) type = '✅ Terminal';
      if (this.errorStates.includes(stateName)) type = '❌ Error';
      if (state.hasConditionalLogic) type += ' (Conditional)';

      table += `| ${stateName} | ${question} | ${transitionsFrom || 'N/A'} | ${type} |\n`;
    }

    return table;
  }

  /**
   * Generate complete documentation
   */
  generateDocumentation() {
    let doc = '# License Selector State Graph\n\n';
    doc += '> **Auto-generated documentation** - Run `npm run generate-graph` to update\n\n';
    doc += '## Overview\n\n';
    doc += 'This document visualizes the decision tree used by the Public License Selector. ';
    doc += 'The selector guides users through a series of questions to recommend appropriate ';
    doc += 'licenses for their software or data.\n\n';

    doc += '## Complete State Graph\n\n';
    doc += '```mermaid\n';
    doc += this.generateMermaid();
    doc += '```\n\n';

    doc += '## Data Licensing Path\n\n';
    doc += '```mermaid\n';
    doc += this.generateMermaid({ filterPath: 'data', title: 'Data Licensing Flow' });
    doc += '```\n\n';

    doc += '## Software Licensing Path\n\n';
    doc += '```mermaid\n';
    doc += this.generateMermaid({ filterPath: 'software', title: 'Software Licensing Flow' });
    doc += '```\n\n';

    doc += '## State Reference Table\n\n';
    doc += this.generateStateTable();
    doc += '\n\n';

    doc += '## Legend\n\n';
    doc += '- 🔹 **Blue nodes**: Data licensing path\n';
    doc += '- 🔸 **Purple nodes**: Software licensing path\n';
    doc += '- ✅ **Green nodes**: Terminal states (license selection)\n';
    doc += '- ❌ **Red nodes**: Error states (cannot license)\n';
    doc += '- ♦️ **Diamond shapes**: Yes/No decisions\n';
    doc += '- ⬜ **Rectangles**: Multi-option questions\n\n';

    doc += '## How to Update\n\n';
    doc += '1. Modify `src/data/questions.coffee`\n';
    doc += '2. Run `npm run generate-graph`\n';
    doc += '3. Review the updated diagrams in this file\n';
    doc += '4. Commit changes to version control\n\n';

    doc += '## Related Files\n\n';
    doc += '- **Question Definitions**: `src/data/questions.coffee`\n';
    doc += '- **License Data**: `src/data/licenses.coffee`\n';
    doc += '- **Compatibility Matrix**: `src/data/compatibility.coffee`\n';
    doc += '- **Generator Script**: `scripts/generate-state-graph.js`\n';

    return doc;
  }
}

// Main execution
function main() {
  const generator = new StateGraphGenerator();

  // Paths
  const projectRoot = path.resolve(__dirname, '..');
  const questionsFile = path.join(projectRoot, 'src', 'data', 'questions.coffee');
  const outputDir = path.join(projectRoot, 'docs');

  // Ensure output directory exists
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }

  console.log('Parsing questions.coffee...');
  generator.parseQuestionsFile(questionsFile);

  console.log(`Found ${Object.keys(generator.states).length} states`);
  console.log(`Found ${generator.transitions.length} transitions`);
  console.log(`Found ${generator.terminalStates.length} terminal states`);
  console.log(`Found ${generator.errorStates.length} error states`);

  // Generate outputs
  console.log('\n📝 Generating documentation...');

  const documentation = generator.generateDocumentation();

  // Write documentation file
  const docFile = path.join(outputDir, 'state-graph.md');

  fs.writeFileSync(docFile, documentation);
  console.log(`Created: ${docFile}`);

  console.log('\n Done! View the state graph in docs/state-graph.md');
  console.log(' Tip: GitHub will automatically render Mermaid diagrams');
}

// Run if called directly
if (require.main === module) {
  main();
}

module.exports = StateGraphGenerator;
