# License Selector State Graph

> **Auto-generated documentation** - Run `npm run generate-graph` to update

## Overview

This document visualizes the decision tree used by the Public License Selector. The selector guides users through a series of questions to recommend appropriate licenses for their software or data.

## Complete State Graph

```mermaid
%%{init: {'theme':'base', 'themeVariables': { 'fontSize':'16px'}, 'flowchart':{'curve':'basis', 'padding':20}}}%%
flowchart TD
    Start([Start]) --> KindOfContent

    KindOfContent{"What do you want to deposit?"}
    DataCopyrightable(["Is your data within the scope of copyright
and related rights?"])
    class DataCopyrightable dataPath
    OwnIPR{"Do you own copyright and similar rights in
your dataset and all its constitutive parts?"}
    class OwnIPR dataPath
    AllowDerivativeWorks(["Do you allow others to make derivative works?"])
    class AllowDerivativeWorks dataPath
    ShareAlike(["Do you require others to share derivative
works based on your data under a compatible
license?"])
    class ShareAlike dataPath
    CommercialUse(["Do you allow others to make commercial use of
you data?"])
    class CommercialUse dataPath
    DecideAttribute(["Do you want others to attribute your data to
you?"])
    class DecideAttribute dataPath
    EnsureLicensing(["Are all the elements of your dataset licensed
under a public license or in the Public
Domain?"])
    class EnsureLicensing dataPath
    LicenseInteropData(["Choose licenses present in your dataset:"])
    class LicenseInteropData dataPath
    YourSoftware["Is your code based on existing software or is
it your original work?"]
    class YourSoftware softwarePath
    LicenseInteropSoftware(["Select licenses in your code:"])
    class LicenseInteropSoftware softwarePath
    Copyleft(["Do you require others who modify your code to
release it under a compatible licence?"])
    class Copyleft softwarePath
    StrongCopyleft(["Is your code used directly as an executable
or are you licensing a library (your code
will be linked)?"])
    class StrongCopyleft softwarePath

    KindOfContent -->YourSoftware
    KindOfContent -->DataCopyrightable
    DataCopyrightable -->|"Yes"| OwnIPR
    OwnIPR -->|"Yes"| AllowDerivativeWorks
    OwnIPR -->|"No"| EnsureLicensing
    AllowDerivativeWorks -->ShareAlike
    AllowDerivativeWorks -->CommercialUse
    ShareAlike -->CommercialUse
    CommercialUse -->DecideAttribute
    EnsureLicensing -->|"Yes"| LicenseInteropData
    LicenseInteropData -->|"Option selected"| AllowDerivativeWorks
    YourSoftware -->|"Based on existing software"| LicenseInteropSoftware
    YourSoftware -->|"My own code"| Copyleft
    LicenseInteropSoftware -->|"Option selected"| Copyleft
    LicenseInteropSoftware -->|"Option selected"| StrongCopyleft
    Copyleft -->StrongCopyleft
    DataCopyrightable --> End([Select License])
    AllowDerivativeWorks --> End([Select License])
    ShareAlike --> End([Select License])
    CommercialUse --> End([Select License])
    DecideAttribute --> End([Select License])
    LicenseInteropData --> End([Select License])
    LicenseInteropSoftware --> End([Select License])
    Copyleft --> End([Select License])
    StrongCopyleft --> End([Select License])
    EnsureLicensing --> Error([Cannot License])
    LicenseInteropData --> Error([Cannot License])
    LicenseInteropSoftware --> Error([Cannot License])

    classDef dataPath fill:#e1f5ff,stroke:#01579b,stroke-width:2px,padding:15px,min-width:250px
    classDef softwarePath fill:#f3e5f5,stroke:#4a148c,stroke-width:2px,padding:15px,min-width:250px
    classDef terminalNode fill:#c8e6c9,stroke:#2e7d32,stroke-width:3px,padding:15px
    classDef errorNode fill:#ffcdd2,stroke:#c62828,stroke-width:3px,padding:15px
```

## Data Licensing Path

```mermaid
%%{init: {'theme':'base', 'themeVariables': { 'fontSize':'16px'}, 'flowchart':{'curve':'basis', 'padding':20}}}%%
flowchart TD
    Start([Start]) --> KindOfContent

    KindOfContent{"What do you want to deposit?"}
    DataCopyrightable(["Is your data within the scope of copyright
and related rights?"])
    class DataCopyrightable dataPath
    OwnIPR{"Do you own copyright and similar rights in
your dataset and all its constitutive parts?"}
    class OwnIPR dataPath
    AllowDerivativeWorks(["Do you allow others to make derivative works?"])
    class AllowDerivativeWorks dataPath
    ShareAlike(["Do you require others to share derivative
works based on your data under a compatible
license?"])
    class ShareAlike dataPath
    CommercialUse(["Do you allow others to make commercial use of
you data?"])
    class CommercialUse dataPath
    DecideAttribute(["Do you want others to attribute your data to
you?"])
    class DecideAttribute dataPath
    EnsureLicensing(["Are all the elements of your dataset licensed
under a public license or in the Public
Domain?"])
    class EnsureLicensing dataPath
    LicenseInteropData(["Choose licenses present in your dataset:"])
    class LicenseInteropData dataPath
    LicenseInteropSoftware(["Select licenses in your code:"])
    class LicenseInteropSoftware softwarePath
    Copyleft(["Do you require others who modify your code to
release it under a compatible licence?"])
    class Copyleft softwarePath
    StrongCopyleft(["Is your code used directly as an executable
or are you licensing a library (your code
will be linked)?"])
    class StrongCopyleft softwarePath

    KindOfContent -->DataCopyrightable
    DataCopyrightable -->|"Yes"| OwnIPR
    OwnIPR -->|"Yes"| AllowDerivativeWorks
    OwnIPR -->|"No"| EnsureLicensing
    AllowDerivativeWorks -->ShareAlike
    AllowDerivativeWorks -->CommercialUse
    ShareAlike -->CommercialUse
    CommercialUse -->DecideAttribute
    EnsureLicensing -->|"Yes"| LicenseInteropData
    LicenseInteropData -->|"Option selected"| AllowDerivativeWorks
    LicenseInteropSoftware -->|"Option selected"| Copyleft
    LicenseInteropSoftware -->|"Option selected"| StrongCopyleft
    Copyleft -->StrongCopyleft
    DataCopyrightable --> End([Select License])
    AllowDerivativeWorks --> End([Select License])
    ShareAlike --> End([Select License])
    CommercialUse --> End([Select License])
    DecideAttribute --> End([Select License])
    LicenseInteropData --> End([Select License])
    LicenseInteropSoftware --> End([Select License])
    Copyleft --> End([Select License])
    StrongCopyleft --> End([Select License])
    EnsureLicensing --> Error([Cannot License])
    LicenseInteropData --> Error([Cannot License])
    LicenseInteropSoftware --> Error([Cannot License])

    classDef dataPath fill:#e1f5ff,stroke:#01579b,stroke-width:2px,padding:15px,min-width:250px
    classDef softwarePath fill:#f3e5f5,stroke:#4a148c,stroke-width:2px,padding:15px,min-width:250px
    classDef terminalNode fill:#c8e6c9,stroke:#2e7d32,stroke-width:3px,padding:15px
    classDef errorNode fill:#ffcdd2,stroke:#c62828,stroke-width:3px,padding:15px
```

## Software Licensing Path

```mermaid
%%{init: {'theme':'base', 'themeVariables': { 'fontSize':'16px'}, 'flowchart':{'curve':'basis', 'padding':20}}}%%
flowchart TD
    Start([Start]) --> KindOfContent

    KindOfContent{"What do you want to deposit?"}
    DataCopyrightable(["Is your data within the scope of copyright
and related rights?"])
    class DataCopyrightable dataPath
    AllowDerivativeWorks(["Do you allow others to make derivative works?"])
    class AllowDerivativeWorks dataPath
    ShareAlike(["Do you require others to share derivative
works based on your data under a compatible
license?"])
    class ShareAlike dataPath
    CommercialUse(["Do you allow others to make commercial use of
you data?"])
    class CommercialUse dataPath
    DecideAttribute(["Do you want others to attribute your data to
you?"])
    class DecideAttribute dataPath
    EnsureLicensing(["Are all the elements of your dataset licensed
under a public license or in the Public
Domain?"])
    class EnsureLicensing dataPath
    LicenseInteropData(["Choose licenses present in your dataset:"])
    class LicenseInteropData dataPath
    YourSoftware["Is your code based on existing software or is
it your original work?"]
    class YourSoftware softwarePath
    LicenseInteropSoftware(["Select licenses in your code:"])
    class LicenseInteropSoftware softwarePath
    Copyleft(["Do you require others who modify your code to
release it under a compatible licence?"])
    class Copyleft softwarePath
    StrongCopyleft(["Is your code used directly as an executable
or are you licensing a library (your code
will be linked)?"])
    class StrongCopyleft softwarePath

    KindOfContent -->YourSoftware
    KindOfContent -->DataCopyrightable
    AllowDerivativeWorks -->ShareAlike
    AllowDerivativeWorks -->CommercialUse
    ShareAlike -->CommercialUse
    CommercialUse -->DecideAttribute
    EnsureLicensing -->|"Yes"| LicenseInteropData
    LicenseInteropData -->|"Option selected"| AllowDerivativeWorks
    YourSoftware -->|"Based on existing software"| LicenseInteropSoftware
    YourSoftware -->|"My own code"| Copyleft
    LicenseInteropSoftware -->|"Option selected"| Copyleft
    LicenseInteropSoftware -->|"Option selected"| StrongCopyleft
    Copyleft -->StrongCopyleft
    DataCopyrightable --> End([Select License])
    AllowDerivativeWorks --> End([Select License])
    ShareAlike --> End([Select License])
    CommercialUse --> End([Select License])
    DecideAttribute --> End([Select License])
    LicenseInteropData --> End([Select License])
    LicenseInteropSoftware --> End([Select License])
    Copyleft --> End([Select License])
    StrongCopyleft --> End([Select License])
    EnsureLicensing --> Error([Cannot License])
    LicenseInteropData --> Error([Cannot License])
    LicenseInteropSoftware --> Error([Cannot License])

    classDef dataPath fill:#e1f5ff,stroke:#01579b,stroke-width:2px,padding:15px,min-width:250px
    classDef softwarePath fill:#f3e5f5,stroke:#4a148c,stroke-width:2px,padding:15px,min-width:250px
    classDef terminalNode fill:#c8e6c9,stroke:#2e7d32,stroke-width:3px,padding:15px
    classDef errorNode fill:#ffcdd2,stroke:#c62828,stroke-width:3px,padding:15px
```

## State Reference Table

| State | Question | Transitions | Type |
|-------|----------|-------------|------|
| KindOfContent | What do you want to deposit? | → YourSoftware<br>→ DataCopyrightable | Question |
| DataCopyrightable | Is your data within the scope of copyright and related rights? | → OwnIPR | ✅ Terminal |
| OwnIPR | Do you own copyright and similar rights in your dataset and all its constitutive parts? | → AllowDerivativeWorks<br>→ EnsureLicensing | Question |
| AllowDerivativeWorks | Do you allow others to make derivative works? | → ShareAlike<br>→ CommercialUse | ✅ Terminal (Conditional) |
| ShareAlike | Do you require others to share derivative works based on your data under a compatible license? | → CommercialUse<br>→ CommercialUse | ✅ Terminal (Conditional) |
| CommercialUse | Do you allow others to make commercial use of you data? | → DecideAttribute | ✅ Terminal (Conditional) |
| DecideAttribute | Do you want others to attribute your data to you? | N/A | ✅ Terminal |
| EnsureLicensing | Are all the elements of your dataset licensed under a public license or in the Public Domain? | → LicenseInteropData | ❌ Error |
| LicenseInteropData | Choose licenses present in your dataset: | → AllowDerivativeWorks<br>→ AllowDerivativeWorks<br>→ AllowDerivativeWorks | ❌ Error |
| YourSoftware | Is your code based on existing software or is it your original work? | → LicenseInteropSoftware<br>→ Copyleft | Question |
| LicenseInteropSoftware | Select licenses in your code: | → Copyleft<br>→ StrongCopyleft | ❌ Error (Conditional) |
| Copyleft | Do you require others who modify your code to release it under a compatible licence? | → StrongCopyleft | ✅ Terminal (Conditional) |
| StrongCopyleft | Is your code used directly as an executable or are you licensing a library (your code will be linked)? | N/A | ✅ Terminal |


## Legend

- 🔹 **Blue nodes**: Data licensing path
- 🔸 **Purple nodes**: Software licensing path
- ✅ **Green nodes**: Terminal states (license selection)
- ❌ **Red nodes**: Error states (cannot license)
- ♦️ **Diamond shapes**: Yes/No decisions
- ⬜ **Rectangles**: Multi-option questions

## How to Update

1. Modify `src/data/questions.coffee`
2. Run `npm run generate-graph`
3. Review the updated diagrams in this file
4. Commit changes to version control

## Related Files

- **Question Definitions**: `src/data/questions.coffee`
- **License Data**: `src/data/licenses.coffee`
- **Compatibility Matrix**: `src/data/compatibility.coffee`
- **Generator Script**: `scripts/generate-state-graph.js`
