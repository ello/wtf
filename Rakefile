namespace :assets do
  desc 'Build the Jekyll site'
  task :precompile do
    sh 'bundle exec jekyll build'
  end
end

begin
  require 'html-proofer'
  task :test => 'assets:precompile' do
    HTMLProofer.check_directory('./_site',
      assume_extension: true,
      hydra: { max_concurrency: 10 },
      parallel: { in_processes: 3 },
      typhoeus: { followlocation: true },
      url_ignore:  [
        'post_url',
        /^\/wtf\/assets/,
        /^\/wtf\/emoji/,
        /appstore.com/,
        /soundcloud.com/,
        /vimeo.com/,
      ],
      url_swap: { /^\/wtf/ => '' },
      verbose: true,
    ).run
  end

  task :default => :test

rescue LoadError
  # Nothing to do
end
