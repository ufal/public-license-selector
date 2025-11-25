// ***********************************************
// Custom Cypress commands for License Selector testing
// ***********************************************

/**
 * Custom command to check if modal is visible
 * The modal auto-opens on page load, so this verifies it's active
 */
Cypress.Commands.add('modalShouldBeVisible', () => {
  cy.get('.license-selector.is-active', { timeout: 10000 }).should('be.visible')
  cy.get('.ls-modal').should('be.visible')
})

/**
 * Custom command to close modal
 */
Cypress.Commands.add('closeModal', () => {
  cy.get('.ls-modal-close').first().click()
  cy.get('.license-selector').should('not.have.class', 'is-active')
})

/**
 * Custom command to reopen the license selector by clicking the link
 */
Cypress.Commands.add('reopenLicenseSelector', () => {
  cy.contains('a', 'Click to open selector').first().click()
  cy.get('.license-selector.is-active', { timeout: 5000 }).should('be.visible')
})

/**
 * Custom command to click an answer button in the questionnaire
 * @param {string} answerText - The text of the answer button to click
 */
Cypress.Commands.add('clickAnswer', (answerText) => {
  cy.get('.ls-question-answers button').contains(answerText).click()
})

/**
 * Custom command to verify a question is displayed
 * @param {string} questionText - Part of the question text to check for
 */
Cypress.Commands.add('questionShouldContain', (questionText) => {
  cy.get('.ls-question-text').should('contain', questionText)
})

/**
 * Custom command to verify licenses are visible
 */
Cypress.Commands.add('licensesShouldBeVisible', () => {
  cy.get('.ls-license-list').should('be.visible')
  cy.get('.ls-license-list ul li').should('have.length.gt', 0)
})

/**
 * Custom command to select a license from the list
 * @param {number} index - Index of the license to select (0-based)
 */
Cypress.Commands.add('selectLicense', (index = 0) => {
  cy.get('.ls-license-list ul li').eq(index).click()
})
