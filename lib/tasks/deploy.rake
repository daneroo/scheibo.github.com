site = (get :destination) || '_site'
exclude = get :deploy_exclude

namespace :deploy do

  desc "deploy site into amazon s3 bucket"
  multitask :amazons3 do
    if (bucket = get :s3bucket)
      if exclude
        sh "s3cmd sync --acl-public --delete-removed --exclude-from #{exclude} #{site}/ s3://#{bucket}"
      else
        sh "s3cmd sync --acl-public --delete-removed #{site}/ s3://#{bucket}"
      end
    else
      puts "FAILURE: Please specify an 's3bucket'"
    end
  end

  # assumes we have the remote set up correctly
  desc "deploy website to github user pages"
  multitask :github do
    require 'git'

    source_branch  = (get :source_branch)  || "source"
    deploy_branch  = (get :deploy_branch)  || "master"
    commit_message = (get :commit_message) || "Site updated at #{Time.now.utc}"

    repo = Git.open('.')
    repo.branch("#{deploy_branch}").checkout
    (Dir["*"] - [site]).each { |f| rm_rf(f) }
    Dir["#{site}/*"].each {|f| mv(f, ".")}
    rm_rf(site)
    Dir["**/*"].each {|f| repo.add(f) }
    repo.status.deleted.each {|f, s| repo.remove(f)}
    repo.commit(commit_message)
    repo.push
    repo.branch("#{source_branch}").checkout
  end

  desc "deploys site into the deploy_path on the remote path using ssh_user"
  multitask :rsync do
    site = (get :desination) || '_site'
    if (ssh_user = get :ssh_user) && (deploy_path = get :deploy_path)
      port = (get :ssh_port) || 22
      if exclude
        sh "rsync -avz --delete --exclude-from #{exclude} -e 'ssh -p #{ssh_port}' #{site}/ #{ssh_user}:#{deploy_path}"
      else
        sh "rsync -avz --delete -e 'ssh -p #{ssh_port}' #{site}/ #{ssh_user}:#{deploy_path}"
      end
    else
      puts "FAILURE: Please specify ssh creditionals and deploy path for the remote box"
    end
  end

end
