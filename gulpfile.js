var gulp = require('gulp');
var uglify = require('gulp-uglify');
var babel = require('gulp-babel');
var pump = require('pump');
var $ = require('gulp-load-plugins')();

var sassPaths = [
    'bower_components/foundation-sites/scss',
    'bower_components/motion-ui/src'
];

gulp.task('sass', function () {
    return gulp.src([
        'app/assets/stylesheets/cavy/scss/app.scss',
        'app/assets/stylesheets/cavy/scss/font-awesome/font-awesome.scss'])
        .pipe($.sass({
            includePaths: sassPaths,
            outputStyle: 'compressed' // if css compressed **file size**
        })
            .on('error', $.sass.logError))
        .pipe($.autoprefixer({
            browsers: ['last 2 versions', 'ie >= 9']
        }))
        .pipe(gulp.dest('app/assets/stylesheets/cavy'));
});

// the js dependencies need to be moved
gulp.task('js', function (cb) {
    pump([
            gulp.src([
                'bower_components/jquery/dist/jquery.js',
                'bower_components/foundation-sites/dist/js/foundation.js']
            ),
            //uglify(),
            gulp.dest('app/assets/javascripts/cavy')
        ],
        cb
    );
});

gulp.task('es6', function () {
    return gulp.src([
        'resources/js/translations.js'])
        .pipe(babel({
            //presets: ['es2015']
        }))
        .pipe(gulp.dest('app/assets/javascripts/cavy'));
});

gulp.task('default', ['sass', 'js', 'es6'], function () {
    gulp.watch(['app/assets/stylesheets/cavy/scss/**/*.scss'], ['sass']);
    gulp.watch(['resources/js/**/*.js'], ['es6']);
});
