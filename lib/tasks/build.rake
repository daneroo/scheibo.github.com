namespace :build do
  desc "TODO"
  task :styles do
    # TODO TODO TODO TODO: fix there, theres got to be a better way
    # file = File.open('css/style.css', 'r').read # WTF RUBY
    # File.open('css/style.css', 'r').grep(/@import\ url\(.*\);/).each do |m|
    #   if m =~ /@import\ url\(["'](.*)["']\);/
    #     sourced_file = File.open("css/#{$1}").read
    #     file.gsub( m, sourced_file)
    #   end
    # end
  end

  desc "concantenates files placed in plugin directory"
  task :plugins do
    sh <<-EOF
    [[ -f js/plugins.js ]] && rm js/plugins.js
    cp js/plugins.js.tmpl js/plugins.js
    cat js/plugins/*.js >> js/plugins.js
EOF
  end

end
