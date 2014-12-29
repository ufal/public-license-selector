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
          'dist/license-selector-clarin.min.js': ['dist/license-selector-clarin.js']

    cssmin:
      dist:
        files:
          'dist/license-selector.min.css': ['dist/license-selector.css']

    buildcontrol:
      options:
        commit: true
        push: true
        connectCommits: true
        message: 'Built %sourceName% from %sourceCommit% on %sourceBranch%'

      pages:
        options:
          dir: 'pages'
          branch: 'gh-pages'
          remote: 'git@github.com:ufal/lindat-license-selector.git'

      release:
        options:
          dir: 'dist'
          branch: 'releases'
          remote: 'git@github.com:ufal/lindat-license-selector.git'
          tag: '<%= pkg.version %>'

    copy:
      pages:
        files: [
          {
            src: 'bower_components/jquery/dist/jquery.min.js'
            dest: 'pages/jquery.min.js'
          },
          {
            src: 'bower_components/lodash/dist/lodash.min.js'
            dest: 'pages/lodash.min.js'
          },
          {
            src: 'src/fonts/*'
            dest: 'pages/fonts/'
            filter: 'isFile'
            expand: true
            flatten: true
          },
          {
            src: 'dist/*.{js,css,map}'
            dest: 'pages/'
            filter: 'isFile'
            expand: true
            flatten: true
          },
          {
            src: '*.md'
            dest: 'pages/'
          }
        ]

      release:
        files: [
          {
            src: ['*.md', 'bower.json']
            dest: 'dist/'
          }
        ]

    clean:
      dist:
        src: 'dist/*'
      pages:
        src: 'pages/*'

    bump:
      options:
        files: ['package.json', 'bower.json']
        updateConfigs: ['pkg']
        commit: true
        commitMessage: 'Release v%VERSION%'
        commitFiles: ['package.json', 'bower.json']
        createTag: false
        tagName: 'v%VERSION%'
        tagMessage: 'Version %VERSION%'
        push: true
        pushTo: 'origin'

    dom_munger:
      release:
        options:
          callback: ($) ->
            $('script[src]').each ->
              $(@).attr 'src', replaceWithMin($(@).attr('src'))
            $('link[rel=stylesheet]').each ->
              $(@).attr 'href', replaceWithMin($(@).attr('href'))
        src: 'index.html'
        dest: 'pages/index.html'

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
      compile:
        options:
          join: true
        files: [
          {
            src: [ 'src/definitions.coffee', 'src/license-selector.coffee' ]
            dest: 'dist/license-selector.js'
          },
          {
            src: [ 'src/definitions.coffee', 'src/license-selector.coffee', 'src/clarin-extension.coffee' ]
            dest: 'dist/license-selector-clarin.js'
          }
        ]

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

  grunt.registerTask('lint', ['coffeelint'])
  grunt.registerTask('start', ['default', 'open:dev', 'connect:livereload', 'watch'])
  grunt.registerTask('default', [
    'clean:dist',
    'coffee',
    'less:dev',
    'lint',
    'uglify',
    'cssmin'
  ])

  grunt.registerTask('pages', [
    'default',
    'clean:pages',
    'copy:pages',
    'dom_munger',
    'buildcontrol:pages'
  ])

  grunt.registerTask('release', [
    'pages',
    'copy:release'
    'buildcontrol:release'
  ])
