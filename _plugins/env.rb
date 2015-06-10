class EnvGenerator < Jekyll::Generator
  def generate(site)
    [
      'segment_write_key'
    ].each do |variable_name|
      site.config[variable_name.to_s.downcase] = ENV[variable_name.to_s.upcase]
    end
  end
end
