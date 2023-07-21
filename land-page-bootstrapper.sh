#!/bin/bash

ht_path="/Users/sriramkasyapm/Works/www/"

alias www="cd /Users/sriramkasyapm/Works/www"

echo "Enter directory name"
read dir_name

echo "Enter Project title"
read page_title

project_name=$(echo $dir_name | cut -d'/' -f 2)
dir_path=$ht_path$dir_name
mkdir $dir_path

cd $dir_path

echo "Installing Bootstrap"
wget -q https://github.com/twbs/bootstrap/archive/v4.0.0.zip -O bootstrap.zip
unzip -q bootstrap.zip
rm $dir_path/bootstrap.zip
bootstrap_dir=$(find $dir_path -mindepth 1 -maxdepth 1 -type d)

echo "Creating inner directories"
mkdir src dist img
mkdir src/scss src/js dist/css dist/js
touch .prettierrc .babelrc index.html src/scss/style.scss src/scss/_universal.scss src/scss/_style_xs.scss src/scss/_style_sm.scss src/scss/_style_md.scss src/scss/_style_lg.scss src/scss/_style_xl.scss  src/scss/_style_xxl.scss src/js/main.js gulpfile.babel.js package.json

mv $bootstrap_dir/scss src/scss/bootstrap
mv src/scss/bootstrap/bootstrap-grid.scss src/scss/bootstrap/_bootstrap-grid.scss
mv src/scss/bootstrap/bootstrap-reboot.scss src/scss/bootstrap/_bootstrap-reboot.scss
mv src/scss/bootstrap/bootstrap.scss src/scss/bootstrap/_bootstrap.scss
mv bootstrap-4.0.0/dist/js/bootstrap.min.js dist/js/bootstrap.min.js
rm -r $bootstrap_dir

echo "Installing jQuery"
wget -q https://code.jquery.com/jquery-3.3.1.min.js -O dist/js/jQuery.js

echo "Writing index.html"
cat > index.html <<EOF
<!DOCTYPE html>
<!--[if lt IE 7]>
<html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en">
   <![endif]-->
<!--[if IE 7]>
   <html class="no-js lt-ie9 lt-ie8" lang="en">
      <![endif]-->
<!--[if IE 8]>
      <html class="no-js lt-ie9" lang="en">
         <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en-US">
    <!--<![endif]-->
    <head>
        <meta charset="UTF-8" />
        <title>$page_title</title>
        <meta name="description" content="" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0" />
        <link rel="icon" href="favicon.ico" />
        <link rel="stylesheet" href="dist/css/style.min.css" />
    </head>
    <body>
        <script src="dist/js/jQuery.js"></script>
        <script src="dist/js/bootstrap.min.js"></script>
        <script src="dist/js/main.js"></script>
    </body>
</html>

EOF

echo "Writing .prettierrc"
cat > .prettierrc <<EOF
{
    "tabWidth": 4,
    "semi": true,
    "singleQuote": false
}
EOF

echo "Writing .babelrc"
cat > .babelrc <<EOF
{
    "presets": ["es2015"]
}

EOF

echo "Writing style.scss"
cat > src/scss/style.scss <<EOF
@import 'bootstrap/bootstrap-grid';
@import 'universal';
@import 'style_xs';
@import 'style_sm';
@import 'style_md';
@import 'style_lg';
@import 'style_xl';
@import 'style_xxl';
EOF

echo "Writing _universal.scss"
cat > src/scss/_universal.scss <<EOF
//Imports
@import url("https://fonts.googleapis.com/css?family=Poppins:400,500");

//Variables
\$primary-font: "Poppins", sans-serif;
\$heading-font: "Poppins", sans-serif;
\$special-font: "Poppins", sans-serif;

\$primary-color: #000000;
\$secondary-color: #f1f7f9;
\$tertiary-color: #00b8e5;

\$special-color: #ed017f;
\$special-color-2: #353495;

\$text-black: #000000;
\$text-grey: #d3d1d3;

\$regular: 400;
\$bold: 500;
\$light: 300;

// Mixins

@mixin transition(\$timing, \$function) {
    transition: all \$timing \$function;
}

@mixin button(\$bg-color, \$bg-i-color, \$text-i-color) {
    padding: 10px 15px;
    text-align: center;
    display: inline-block;
    background-color: \$bg-color;
    border: 1px solid \$bg-color;
    @include transition(0.2s, ease-in-out);
    border-radius: 6px;
    cursor: pointer;
    &:hover,
    &:active,
    &:focus {
        background-color: \$bg-i-color;
        color: \$text-i-color;
    }
    &.hover-black {
        &:hover,
        &:active,
        &:focus {
            color: \$text-black;
        }
    }
}
@mixin flexbox() {
    display: flex;
    flex-wrap: wrap;
    flex-direction: row;
    align-items: flex-start;
}

@mixin gridbox() {
    display: grid;
}

body {
    margin: 0;
    font-family: \$primary-font;
    font-weight: \$regular;
    color: \$text-black;
}
p,
li,
a {
    font-size: 14px;
}
h1,
h2,
h3,
h4,
h5,
h6,
.heading-text {
    font-family: \$heading-font;
    font-weight: \$bold;
}
a {
    text-decoration: none;
    color: \$text-black;
}
img {
    display: block;
    max-width: 100%;
    max-height: 100%;
    user-select: none;
    height: auto;
    width: auto;
}
ul {
    margin: 0;
    padding: 0;
    &.show-bullets {
        padding-left: 15px;
        li {
            list-style-type: disc;
        }
    }
    li {
        list-style-type: none;
    }
}
input,
textarea,
select {
    outline: none;
    background: none;
    border: 0px;
    color: \$text-black;
    box-shadow: none;
    margin: 0;
    border-radius: 0;
    -webkit-appearance: textfield;
    font-family: \$primary-font;
    &:-moz-placeholder,
    &:-moz-placeholder,
    &::-ms-input-placeholder {
        font-family: \$primary-font;
    }
}
.special-font-text {
    font-family: \$special-font;
}
.light-text {
    font-weight: \$light;
}
.regular-text {
    font-weight: \$regular;
}
.regular-font-text {
    font-family: \$primary-font;
}
.bold-text {
    font-weight: \$bold;
}
.extra-bold-text {
    font-weight: 800;
}

.text-center {
    text-align: center;
}
.text-right {
    text-align: right;
}
.upper-text {
    text-transform: uppercase;
}
.cap-text {
    text-transform: capitalize;
}

.ml-auto {
    margin-left: auto;
}
.mr-auto {
    margin-right: auto;
}
.center-block,
.m-auto {
    display: block;
    @extend .ml-auto;
    @extend .mr-auto;
}
.w-100 {
    flex: 100%;
}

.primary-color-text {
    color: \$primary-color;
}
.secondary-color-text {
    color: \$secondary-color;
}
.tertiary-color-text {
    color: \$tertiary-color;
}
.special-color-text {
    color: \$special-color;
}
.grey-text {
    color: \$text-grey;
}
.white-text {
    color: white;
}

.primary-color-bg {
    background-color: \$primary-color;
}
.secondary-color-bg {
    background-color: \$secondary-color;
}
.tertiary-color-bg {
    background-color: \$tertiary-color;
}
.special-color-bg {
    background-color: \$special-color;
}
.special-color-2-bg {
    background-color: \$special-color-2;
}

.white-bg {
    background-color: #fff;
}

.primary-color-button {
    @include button(\$primary-color, transparent, \$primary-color);
}
.secondary-color-button {
    @include button(\$secondary-color, transparent, \$text-black);
}
.tertiary-color-button {
    @include button(\$tertiary-color, transparent, white);
}
.white-btn {
    @include button(white, transparent, \$primary-color);
}
EOF

echo "Writing _style_xs.scss"
cat > src/scss/_style_xs.scss <<EOF
@media only screen and (min-width: 0px) {
    .df {
        @include flexbox();
    }
}
EOF

echo "Writing _style_sm.scss"
cat > src/scss/_style_sm.scss <<EOF
@media only screen and (min-width: 576px) {

}
EOF

echo "Writing _style_md.scss"
cat > src/scss/_style_md.scss <<EOF
@media only screen and (min-width: 768px) {

}
EOF

echo "Writing _style_lg.scss"
cat > src/scss/_style_lg.scss <<EOF
@media only screen and (min-width: 992px) {
    .dflg {
        @include flexbox();
    }
}
EOF

echo "Writing _style_xl.scss"
cat > src/scss/_style_xl.scss <<EOF
@media only screen and (min-width: 1200px) {

}
EOF

echo "Writing _style_xxl.scss"
cat > src/scss/_style_xxl.scss <<EOF
@media only screen and (min-width: 1600px) {
    .container {
        max-width: 1540px;
    }
}
EOF


echo "Writing gulpfile.babel.js"
cat > gulpfile.babel.js <<EOF
/**
 * Gulpfile
 * Author: Sriram Kasyap Meduri
 * Date: 24th Jan, 2019
 * Required Gulp Version: 4.0.0
 *
 * Description: Gulp file to Compile SASS/SCSS, Transpile, Bundle and Minify JS files, then serve them via browserSync.
 */

/**
 * Project Constants
 *
 * Change the project name and URL as require. No need to change others unless absolutely required.
 */
"use strict";

var project = "$dir_name",
    projectURL = `http://localhost/${project}/`,
    styleSRC = "src/scss",
    styleDestination = "dist/css",
    scriptSRC = "src/js",
    scriptDestination = "dist/js",
    imgSRC = "img",
    imgDest = "dist/img",
    phpWatchFiles = "**/*.php",
    htmlWatchFiles = "**/*.html";

/**
 * Load Plugins
 */
const gulp = require("gulp");
const sass = require("gulp-sass")(require("sass"));
import autoprefixer from "gulp-autoprefixer";
import sourcemaps from "gulp-sourcemaps";
import rename from "gulp-rename";
import notify from "gulp-notify";
import minify from "gulp-minify";
import babel from "gulp-babel";
import filter from "gulp-filter";
import imagemin from "gulp-imagemin";

/**
 * These plugins are old school cool
 */
var lec = require("gulp-line-ending-corrector"),
    mmq = require("gulp-merge-media-queries"),
    browserSync = require("browser-sync").create();

/**
 * Browsers to be targeted by Autoprefixer
 */
const AUTOPREFIXER_BROWSERS = [
    "last 2 version",
    "> 1%",
    "ie >= 9",
    "ie_mob >= 10",
    "ff >= 30",
    "chrome >= 34",
    "safari >= 7",
    "opera >= 23",
    "ios >= 7",
    "android >= 4",
    "bb >= 10",
];

/**
 * Initialize the BrowserSync. It's the Key!
 */
const browserSyncStart = (done) => {
    browserSync.init({
        proxy: projectURL,
        open: true,
        injectChanges: true,
    });
    done();
};

/**
 * Task to reload Browser using BrowserSync
 */
const reload = (done) => {
    browserSync.reload();
    done();
};

/**
 * Compile SASS/SCSS files to single style.min.css file,
 * Autoprefix for Cross-Browser compatibility,
 * merge multiple media queries,
 * Correct line endings, and
 * Inject the changes into the browser
 */
const compileSass = (done) => {
    gulp.src(`${styleSRC}/**/*.scss`)
        .pipe(sourcemaps.init({ loadMaps: true }))
        .pipe(
            sass({
                errLogToConsole: true,
                outputStyle: "compressed",
                sourceComments: "map",
                sourceMap: "sass",
            })
        )
        .on("error", console.error.bind(console))
        .pipe(autoprefixer(AUTOPREFIXER_BROWSERS))
        .pipe(rename("style.min.css"))
        .pipe(gulp.dest(styleDestination))
        .pipe(filter("**/*.css"))
        .pipe(mmq({ log: true }))
        .pipe(lec())
        .pipe(browserSync.stream())
        .pipe(notify("Stylesheets Compiled! 💯"));
    done();
};

/**
 * Transpile Javascript (or ES6 if you wanna be super cool),
 * minify it and put it in it's place (Script Destination, obviously)
 */
const compileJS = (done) => {
    gulp.src(`${scriptSRC}/**/*.js`)
        .pipe(babel())
        .pipe(
            minify({
                ext: {
                    min: ".js",
                },
            })
        )
        .pipe(gulp.dest(scriptDestination))
        .pipe(notify("Scripts Compiled! 💯"));
    done();
};

/**
 * Optimize images, because who wants a slow web page?
 * Then also show them their place.
 */
const optimizeImg = (done) => {
    gulp.src(`${imgSRC}/*`)
        .pipe(
            imagemin({
                progressive: true,
            })
        )
        .pipe(gulp.dest(imgDest))
        .pipe(notify({ message: "Images optimized! 💯", onLast: true }));
    done();
};

/**
 * Watch Sass files in Style Sources folder for changes and Compile.
 */
const watchSass = (done) => {
    gulp.watch(`${styleSRC}/**/*.scss`, compileSass);
    done();
};

/**
 * Watch Javascript files for changes and compile them if they do.
 */
const watchJS = (done) => {
    gulp.watch(`${scriptSRC}/**/*.js`, gulp.series(compileJS, reload));
    done();
};

/**
 * Watch images for changes and Optimize the hell out of them
 */
const watchImg = (done) => {
    gulp.watch(`${imgSRC}/*`, optimizeImg);
    done();
};

/**
 * Life is too short to keep hitting F5 and Cmd + R
 * Watch HTML Files for changes and reload the web page when they do.
 */
const watchHTML = (done) => {
    gulp.watch(htmlWatchFiles, reload);
    done();
};

/**
 * Life is still Short..
 * Watch PHP files for changes and reload the web page when they do.
 */
const watchPHP = (done) => {
    gulp.watch(phpWatchFiles, reload);
    done();
};

/**
 * Watch Image destination folder for new optimized images and reload the web page.
 */
const watchDistImg = (done) => {
    gulp.watch(imgDest, reload);
    done();
};

/**
 * Make all the watch tasks to watch over us from this one single 'watch'.
 */
const watch = gulp.parallel(
    watchSass,
    watchJS,
    watchPHP,
    watchHTML,
    watchImg,
    watchDistImg
);

/**
 * Compile the s**t out of all the compiling tasks with one compile command
 */
const compile = gulp.parallel(compileSass, compileJS, optimizeImg);

/**
 * The File is ready for Gulp(ing). 'serve' it hot
 */
const serve = gulp.series(compile, browserSyncStart);

/**
 * The Default Task. The Start Switch. The first domino
 */
const defaultTask = gulp.parallel(serve, watch);

/*
*   Build Task: Compile sass, JS and optimize images
*/
const build = gulp.series(compileSass, compileJS, optimizeImg);

/**
 * Let's start Shippin'
 */
export { compile, serve, watch, build };
export default defaultTask;
EOF


echo "Creating main.js"
touch src/js/main.js

echo "Writing to package.json"
cat > package.json <<EOF
{
    "name": "$project_name",
    "author": "Sriram Kasyap Meduri",
    "version": "2.0.0",
    "license": "GPL-2.0",
    "dependencies": {},
    "devDependencies": {
        "babel-core": "^6.0",
        "babel-plugin-syntax-async-functions": "^6.13.0",
        "babel-plugin-transform-runtime": "^6.23.0",
        "babel-polyfill": "^6.26.0",
        "babel-preset-env": "^1.7.0",
        "babel-preset-es2015": "^6.24.1",
        "babel-register": "^6.26.0",
        "browser-sync": "^2.26.3",
        "gulp": "^4.0.2",
        "gulp-autoprefixer": "^6.0.0",
        "gulp-babel": "^7.0.0",
        "gulp-filter": "^5.1.0",
        "gulp-imagemin": "^5.0.3",
        "gulp-line-ending-corrector": "^1.0.3",
        "gulp-merge-media-queries": "^0.2.1",
        "gulp-minify": "^3.1.0",
        "gulp-notify": "^3.2.0",
        "gulp-rename": "^1.4.0",
        "gulp-sass": "^5.1.0",
        "gulp-sourcemaps": "^2.6.4",
        "regenerator-runtime": "^0.13.1",
        "sass": "^1.64.0"
    },
    "scripts": {
        "build": "gulp build && cp -r *.html dist",
        "dev": "gulp",
        "start": "gulp"
    }
}

EOF




code $dir_path
code $dir_path/index.html
code $dir_path/src/scss/_style_xs.scss
code $dir_path/src/scss/_style_sm.scss
code $dir_path/src/scss/_style_md.scss
code $dir_path/src/scss/_style_lg.scss
code $dir_path/src/scss/_style_xl.scss
code $dir_path/src/scss/_style_xxl.scss
code $dir_path/src/scss/_universal.scss
code $dir_path/src/js/main.js


cd $dir_path


open $dir_path

echo "Installing NPM modules"
npm i && gulp
