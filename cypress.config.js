const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    baseUrl: process.env.CYPRESS_BASE_URL || "https://ufal.github.io/public-license-selector",
    viewportWidth: 1280,
    viewportHeight: 720,

    // Enable video and screenshots in CI for debugging; disable locally to save resources
    video: !!process.env.CI,
    screenshotOnRunFailure: !!process.env.CI,

    defaultCommandTimeout: 10000,
    pageLoadTimeout: 30000,

    retries: {
      runMode: 2,
      openMode: 0,
    },


    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});
