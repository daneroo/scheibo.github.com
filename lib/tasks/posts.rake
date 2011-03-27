source = (get(:source) || '.')

namespace :posts do

  desc "creates a new unpublished post"
  task :new do
    title = (ENV['TITLE'] || grab_input("Post Title: ", "Untitled"))
    format = (ENV['FORMAT'] || 'markdown')

    open("#{source}/_posts/#{Time.now.strftime('%y-%m-%d')}-#{title.downcase.gsub(/[ _]/, '-')}.#{format}", 'w') do |post|
      post.puts "---\nlayout: post\ntitle: #{title}\ndate: #{Time.now}\nslug:\ntags: []\n\nhackernews:\n\npublish: false\n---"
    end
  end

end
