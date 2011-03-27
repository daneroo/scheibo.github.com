task :jekyll => ['jekyll:generate']

namespace :ejekyll do

  desc "runs jekyll on the source"
  task :generate do
    sh "ejekyll"
  end

  desc "runs jekyll to serve the pages"
  task :server do
    sh "ejekyll --server"
  end

  desc "runs jekyll in auto watching mode"
  task :auto do
    sh "ejekyll --auto"
  end

  desc "runs jekyll in server and auto watching mode"
  task :auto do
    sh "ejekyll --server --auto"
  end

end
