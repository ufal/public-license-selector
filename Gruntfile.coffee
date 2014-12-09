LIVERELOAD_PORT = 35729
lrSnippet = require('connect-livereload')({ port: LIVERELOAD_PORT })

module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    # release:
    #   options:
    #     additionalFiles: ['bower.json']
    #     tagName: 'v<%= version %>'
    #     npm: false
    #     commitMessage: 'Release v<%= version %>'
    #     tagMessage: 'Version v<%= version %>'

    watch:
      coffee:
        files: ['src/*.coffee', '*.coffee']
        tasks: ['coffee']
      less:
        files: ['src/*.less']
        tasks: ['less:dev']
      livereload:
        options:
          livereload: LIVERELOAD_PORT
        files: ['*.html', 'dist/*.js', 'dist/*.css']

    open:
      dev:
        path: 'http://localhost:1337'
        options:
          openOn: 'connect.livereload.listening'

    less:
      dev:
        options:
          paths: ['src/']
        files:
          'dist/license-selector.css': 'src/license-selector.less'

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
        dest: 'dist'
        ext: '.js'

    lesslint:
      src: ['src/*.less']

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
          middleware: (connect) ->
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
    rm('dist')

  grunt.registerTask('lint', ['coffeelint'])
  grunt.registerTask('start', ['default', 'open:dev', 'connect:livereload', 'watch'])
  grunt.registerTask('default', ['coffee', 'less:dev', 'lint'])
