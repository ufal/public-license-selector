const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    baseUrl: "https://ufal.github.io/public-license-selector/",
    viewportWidth: 1280,
    viewportHeight: 720,

    video: false,
    screenshotOnRunFailure: false,

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
