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
                      verbose: true,
                      assume_extension: true,
                      parallel: { in_processes: 3 },
                      # Can eventually move to url_swap when https://github.com/gjtorikian/html-proofer/issues/219 is merged
                      url_swap:  { /^\/wtf/ => '' },
                      url_ignore:  [
                        'post_url',
                        /^\/wtf\/assets/,
                        /^\/wtf\/emoji/,
                        /appstore.com/,
                        /soundcloud.com/,
                        /vimeo.com/,
                      ],
                      typhoeus: {
                        followlocation: true,
                        headers: { 'User-Agent' => 'Mozilla/5.0 (compatible; Ello html-proofer' }
                      },
                      hydra: {
                        max_concurrency: 10
                      }
                     ).run
  end

  task :default => :test

rescue LoadError
  # Nothing to do
end
