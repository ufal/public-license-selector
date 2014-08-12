LIVERELOAD_PORT = 35729
lrSnippet = require('connect-livereload')({ port: LIVERELOAD_PORT })

module.exports = (grunt) ->
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    watch:
      coffee:
        files: ['src/*.coffee', '*.coffee']
        tasks: ['coffee']
      livereload:
        options:
          livereload: LIVERELOAD_PORT
        files: ['*.html', '*.coffee']

    coffee:
      # prototype:
      #   options:
      #     sourceMap: true
      #   files:
      #     'prototype.js': 'prototype.coffee'
      glob_to_multiple:
        expand: true
        cwd: 'src'
        src: ['*.coffee']
        dest: 'lib'
        ext: '.js'

    coffeelint:
      options:
        no_empty_param_list:
          level: 'error'
        max_line_length:
          level: 'ignore'

      src: ['src/*.coffee']
      test: ['spec/*.coffee']
      gruntfile: ['Gruntfile.coffee']

    connect:
      livereload:
        options:
          port: 1337
          hostname: 'localhost'
          livereload: LIVERELOAD_PORT
          middleware: (connect) =>
            connect.static.mime.define(
              'image/svg+xml': ['svg']
              'application/x-font-ttf' : ['ttf']
              'application/x-font-opentype' : ['otf']
              'application/x-font-woff' : ['woff']
              'application/vnd.ms-fontobject' : ['eof']
              'text/coffeescript' : ['coffee']
            )
            [lrSnippet, connect.static(require('path').resolve(__dirname))]

  grunt.registerTask 'clean', ->
    rm = (pathToDelete) ->
      grunt.file.delete(pathToDelete) if grunt.file.exists(pathToDelete)
    rm('lib')

  grunt.registerTask('lint', ['coffeelint'])
  grunt.registerTask('start', ['default', 'connect:livereload', 'watch'])
  grunt.registerTask('default', ['coffee', 'lint'])
