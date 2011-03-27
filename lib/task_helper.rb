module TaskHelper

  CONFIG = YAML.load(File.open(File.expand_path('_config.yml')))

  def get(val)
    val = val.to_s
    ENV[val.upcase] || CONFIG[val];
  end

  def ask(question)
    print question
    STDIN.gets
  end

  def grab_input(question, default)
    input = ask(question).strip
    if input.empty?
      return  default
    else
      return input
    end
  end

end
