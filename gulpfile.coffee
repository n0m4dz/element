### loading node modules ###
gulp    = require 'gulp'
plumber = require 'gulp-plumber'
gutil   = require 'gulp-util'
clean   = require 'gulp-clean'
bower   = require 'main-bower-files'
jade    = require 'gulp-jade'
sass    = require 'gulp-ruby-sass'
concat  = require 'gulp-concat'
connect = require 'gulp-connect'

### globals ###
el = 
	"src" : "./src/"	
	"dist" : "./dist/"
	"dev" : "./.tmp/"
	"demo" : "./demo/"

### Tasks ###

# Clean task
# Clean previous files
gulp.task 'clean', ->
	gulp.src el.dev+'*', read: false
		.pipe clean() 

# Bower task
# Copy bower main files
gulp.task 'bower', ->
	gulp.src bower(
				paths: 
        			bowerDirectory: './bower_components',
        			bowerrc: './.bowerrc',
        			bowerJson: './bower.json'
    			)
		.pipe plumber()
		.pipe gulp.dest el.dev+'vendors'

# Template task
# Converting template to .html // Jade templating
gulp.task 'template', ->
	gulp.src el.src + '*.jade'
		.pipe jade()
		.pipe gulp.dest el.dev	

# Sass task
# Convert .scss to .css 
gulp.task 'sass', ->
	gulp.src el.src+'scss/**/*.scss'
		.pipe plumber()
		.pipe sass
			compass: true,
			sourcemap: true,
			sourcemapPath: '../../src/scss/'		
		.pipe gulp.dest el.dev+'css/'		


# Watch task
# Watching file changes in src
gulp.task 'watch', ->
	gulp.watch el.src+'**/*.jade', ['template']
	gulp.watch el.src+'scss/**/*.scss', ['sass']
	

# Server task
# Listen port
gulp.task 'connect', ->
	connect.server(
		root: [el.dev],
		port: 9009		
	)  
	

# Test task
# Unit testing for coffee file
gulp.task 'jasmine', ->
	console.log 'unit test using jasmine'


# Minify task
# Preparing into production mode
gulp.task 'minify', ->
	console.log 'minify'


### Running tasks mode ###
gulp.task 'default', ['clean', 'bower', 'template', 'sass', 'connect', 'watch']
gulp.task 'test',  ['test']
gulp.task 'build', ['minify']
