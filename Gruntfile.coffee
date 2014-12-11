LIVERELOAD_PORT = 35729
lrSnippet = require('connect-livereload')({ port: LIVERELOAD_PORT })

replaceWithMin = (path) ->
  parts = path.split('/')
  basename = parts[parts.length - 1]
  parts = basename.split('.')
  ext = parts.pop()
  parts.join('.') + '.min.' + ext

module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    uglify:
      dist:
        options:
          sourceMap: true
        files:
          'dist/license-selector.min.js': ['dist/license-selector.js']

    cssmin:
      dist:
        files:
          'dist/license-selector.min.css': ['dist/license-selector.css']

    buildcontrol:
      options:
        dir: 'dist'
        commit: true
        push: true
        connectCommits: true
        message: 'Built %sourceName% from commit %sourceCommit% on branch %sourceBranch%'

      pages:
        options:
          branch: 'gh-pages'

      release:
        options:
          branch: 'releases'

    copy:
      pages:
        files: [
          {
            src: 'bower_components/jquery/dist/jquery.min.js'
            dest: 'dist/jquery.min.js'
          },
          {
            src: 'bower_components/lodash/dist/lodash.min.js'
            dest: 'dist/lodash.min.js'
          },
          {
            src: 'src/fonts/*'
            dest: 'dist/fonts/'
          },
          {
            src: '*.md'
            dest: 'dist/'
          }
        ]

      release:
        files: [
          {
            src: ['*.md', 'bower.json']
            dest: 'dist/'
          }
        ]

    bump:
      options:
        files: ['package.json', 'bower.json']
        updateConfigs: ['pkg']
        commit: true
        commitMessage: 'Release v%VERSION%'
        commitFiles: ['package.json', 'bower.json']
        createTag: true
        tagName: 'v%VERSION%'
        tagMessage: 'Version %VERSION%'
        push: true

    dom_munger:
      release:
        options:
          callback: ($) ->
            $('script[src]').each ->
              $(@).attr 'src', replaceWithMin($(@).attr('src'))
            $('link[rel=stylesheet]').each ->
              $(@).attr 'href', replaceWithMin($(@).attr('href'))
        src: 'index.html'
        dest: 'dist/index.html'

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
  grunt.registerTask('default', [
    'clean',
    'coffee',
    'less:dev',
    'lint',
    'uglify',
    'cssmin'
  ])

  grunt.registerTask('pages', [
    'default',
    'copy:pages',
    'dom_munger',
    'buildcontrol:pages'
  ])

  grunt.registerTask('release', [
    'bump',
    'pages',
    'default',
    'copy:release'
    'buildcontrol:release'
  ])
