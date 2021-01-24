const MODE = "development";
const enabledSourceMap = MODE === "development";

const glob = require("glob");
const path = require("path");

const {WebpackManifestPlugin} = require('webpack-manifest-plugin');

const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');


// jQueryで使用
const webpack = require('webpack');

// const TerserPlugin = require('terser-webpack-plugin');

let entries = {}
glob.sync("./src/js/*.js").map(file => {
  let name = file.split("/")[2].split(".")[0]
  entries[name] = file
})

module.exports = {
  mode: 'development',
  entry: entries,
  output: {
    filename: "js/[name]-[hash].js",
    path: path.join(__dirname, 'public')
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
        test: /\.css$/,
        use: [
          "style-loader",
          "css-loader"
        ],
      },
      {
        test: /\.scss$/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader,
            options: {
              esModule: false,
            },
          },
          { loader: 'css-loader' },
          { loader: 'sass-loader' },
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
    }),
    new MiniCssExtractPlugin({ 
      filename: 'stylesheets/[name].css'
    }),
    new WebpackManifestPlugin({
      fileName: 'manifest.json',
      writeToFileEmit: true,
    }),
  ],
  optimization: {
    minimizer: [new OptimizeCSSAssetsPlugin({})],
  },
}