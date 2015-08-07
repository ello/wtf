namespace :assets do
  desc 'Build the Jekyll site'
  task :precompile do
    sh 'bundle exec jekyll build'
  end
end

begin
  require 'html/proofer'
  task :test => 'assets:precompile' do
    HTML::Proofer.new('./_site',
                      parallel: { in_processes: 3 },
                      # Can eventually move to url_swap when https://github.com/gjtorikian/html-proofer/issues/219 is merged
                      href_swap:  { /^\/wtf/ => '' },
                      url_ignore:  [
                        'post_url',
                        '#toggle_drawer',
                        /^\/wtf\/assets/,
                        /^\/wtf\/emoji/
                      ],
                      typhoeus: {
                        ssl_verifypeer: false,
                        ssl_verifyhost: 0
                      }).run
  end

  task :default => :test

rescue LoadError
  # Nothing to do
end
