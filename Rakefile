namespace :assets do
  task :precompile do
    puts `bundle exec jekyll build`
  end
end

begin
  require 'html/proofer'

  task :test do
    sh 'bundle exec jekyll build'
    HTML::Proofer.new('./_site', parallel: { in_processes: 3 }).run
  end

rescue LoadError
  # Nothing to do
end
