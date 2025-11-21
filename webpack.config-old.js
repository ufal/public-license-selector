/* jshint node:true */

var path = require('path');
var webpack = require('webpack');
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var HtmlWebpackPlugin = require('html-webpack-plugin');

var pgk = require('./package.json');

var defines = new webpack.DefinePlugin({
  VERSION: JSON.stringify(pgk.version)
});

module.exports = {
  devtool: 'source-map',
  entry: ['./src/license-selector.coffee', './src/license-selector.less'],
  output: {
    path: path.join(__dirname, 'dist'),
    filename: 'license-selector.js'
  },
  externals: {
    lodash: '_',
    jquery: 'jQuery'
  },
  module: {
    loaders: [
      {test: /\.less$/, loader: ExtractTextPlugin.extract('css!autoprefixer!less')},
      {test: /\.(png|jpg)$/, loader: 'url-loader?limit=8192'}, // inline base64 URLs for <=8k images, direct URLs for the rest
      {test: /\.coffee$/, loader: 'coffee'},
      {test: /\.(woff|woff2)$/, loader: 'url?limit=10000&mimetype=application/font-woff&prefix=fonts'},
      {test: /\.ttf$/, loader: 'url?limit=10000&mimetype=application/octet-stream&prefix=fonts'},
      {test: /\.eot$/, loader: 'url?limit=10000&mimetype=application/vnd.ms-fontobject&prefix=fonts'},
      {test: /\.svg$/, loader: 'url?limit=10000&mimetype=image/svg+xml&prefix=fonts'}
    ]
  },
  plugins: [
    new webpack.optimize.DedupePlugin(),
    new HtmlWebpackPlugin({
      template: path.join(__dirname, 'index.html')
    }),
    new ExtractTextPlugin('license-selector.css', {
      allChunks: true
    }),
    defines
  ]
};
