const MODE = "development";
const enabledSourceMap = MODE === "development";

const glob = require("glob");
const path = require("path");

const {WebpackManifestPlugin} = require('webpack-manifest-plugin');

const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');


// jQueryで使用
const webpack = require('webpack');

const AutoPrefixer = require('autoprefixer');
const TerserPlugin = require('terser-webpack-plugin');

// let entries = {}
// glob.sync("./src/js/*.js").map(file => {
//   let name = file.split("/")[2].split(".")[0]
//   entries[name] = file
// })

module.exports = {
  mode: 'development',
  entry: {
    application: './src/js/index.js',
    meetings_new: './src/js/modules/meetings-new.js',
    meetings_index: './src/js/modules/meetings-index.js'},
  output: {
    filename: "js/[name]-[hash].js",
    path: path.join(__dirname, 'public/assets')
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'babel-loader',
            options: {
              presets: [['@babel/preset-env', { modules: false }]]
            }
          }
        ]
      },
      {
        test: /\.(c|sc)ss$/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader,
            options: {
              publicPath: path.resolve(__dirname, 'public/assets/stylesheets'),
            }
          },
          {
            loader: 'css-loader',
          },
          {
            loader: 'postcss-loader',
            options: {
              postcssOptions: {
                plugins: [
                    require('cssnano')(),
                    require('autoprefixer')({ grid: true })
                ],
              },
            }
          },
          { loader: 'sass-loader', }
        ]
      },
      {
        test: /\.(png|jpe?g|gif)$/i,
        use: [
          {
            loader: 'file-loader',
            options: {
              limit: 51200,
              name: '../images/[name].[ext]'
            }
          }
        ]
      }
    ],
  },
  plugins: [
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      'window.jQuery': 'jquery'
    }),
    new MiniCssExtractPlugin({ 
      filename: 'stylesheets/[name].css'
    }),
    new WebpackManifestPlugin({
      fileName: 'manifest.json',
      publicPath: '/assets/',
      writeToFileEmit: true,
    }),
  ],
  optimization: {
    minimizer: [new OptimizeCSSAssetsPlugin({})],
  },
  devServer: {
    host: 'localhost',
    port: 3035,
    publicPath: 'http://localhost:3035/public/assets/',
    contentBase: path.resolve(__dirname, 'public/assets'),
    hot: true,
    disableHostCheck: true,
    historyApiFallback: true
  },
}