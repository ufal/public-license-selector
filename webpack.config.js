/* eslint-env node */
const path = require('path');
const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const pkg = require('./package.json');

const baseConfig = {
  mode: process.env.NODE_ENV === 'production' ? 'production' : 'development',
  devtool: 'source-map',
  entry: {
    'license-selector': ['./src/index.coffee', './src/license-selector.less']
  },
  externals: {
    lodash: '_',
    jquery: 'jQuery'
  },
  module: {
    rules: [
      {
        test: /\.coffee$/,
        use: [
          {
            loader: 'babel-loader'
          },
          {
            loader: 'coffee-loader'
          }
        ]
      },
      {
        test: /\.less$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          {
            loader: 'less-loader',
            options: {
              lessOptions: {
                javascriptEnabled: true,
                math: 'always'
              }
            }
          }
        ]
      },
      {
        test: /\.(png|jpg|gif|svg)$/,
        type: 'asset',
        parser: {
          dataUrlCondition: {
            maxSize: 8 * 1024
          }
        }
      },
      {
        test: /\.(woff2?|ttf|eot)$/,
        type: 'asset/resource'
      }
    ]
  },
  resolve: {
    extensions: ['.coffee', '.js']
  },
  plugins: [
    new webpack.DefinePlugin({
      VERSION: JSON.stringify(pkg.version)
    }),
    new MiniCssExtractPlugin({
      filename: '[name].css'
    }),
    new HtmlWebpackPlugin({
      template: path.join(__dirname, 'index.html'),
      inject: 'body',
      scriptLoading: 'blocking'
    })
  ],
  optimization: {
    minimize: process.env.NODE_ENV === 'production'
  }
};

const umdConfig = {
  ...baseConfig,
  output: {
    path: path.join(__dirname, 'dist'),
    filename: '[name].umd.js',
    library: {
      name: 'LicenseSelector',
      type: 'umd'
    },
    globalObject: 'this'
  }
};

const esmConfig = {
  ...baseConfig,
  target: 'es2020',
  experiments: {
    outputModule: true
  },
  output: {
    path: path.join(__dirname, 'dist'),
    filename: '[name].esm.js',
    module: true
  },
  // ESM bundles target module consumers, so they expect package import names
  // rather than the global identifiers used by the UMD build.
  externals: {
    lodash: 'lodash',
    jquery: 'jquery'
  },
  plugins: baseConfig.plugins.filter((plugin) => !(plugin instanceof HtmlWebpackPlugin))
};

const configurations = {
  umd: umdConfig,
  esm: esmConfig
};

module.exports = (env = {}) => {
  const targets = env.bundle ? [env.bundle] : Object.keys(configurations);
  return targets.map((target) => {
    if (!configurations[target]) {
      throw new Error(`Unknown bundle: ${target}`);
    }
    return configurations[target];
  });
};
