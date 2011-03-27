require 'rubygems'
require 'rake/clean'
require 'yaml'

require './lib/task_helper'
include TaskHelper

Dir.glob('lib/tasks/**/*.rake').each { |r| Rake.application.add_import r }

# tasks include:
# - deploy (s3, rsync, github)
# - build (concatenate - style and plugins)
# - compress (compress css and js)
# - tidy (pretty print html and (css?))
# - validate (w3c validation)
#
# provide a jekyll wrapper as well

CLEAN.include "_site", 'js/plugins.js'

# Default tasks
#task :default => [:generate, :deploy]
#task :generate => [:concatenate, 'jekyll:generate' ]

#desc "default deployment method"
#task :deploy => [:github]

#desc "default concatenation method"
#task :concatenate => [:all]

#desc "default compression method"
#task :compress => [:js]

#desc "default tidy task"
#task :tidy => [:html]

#desc "default validation"
#task :validate => [:all]

#desc "default build task"
#task :build => [:all]

desc "prepare javascript and css files"
task :prepare => [:plugins, :styles]

desc "runs jekyll to produce the site"
task :create => [:production, :prepare] do
  sh 'jekyll'
end



