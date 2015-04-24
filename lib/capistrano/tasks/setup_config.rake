desc "Get the ball rolling"

task :setup_config do
  # "mkdir /var/www/ellowtf_site/shared"
  on roles(:all) do |host|
    # set up main directory
    if !test("[ -w #{fetch(:deploy_to)} ]")
      execute("mkdir #{fetch(:deploy_to)}")
    end

    # set up shared directory
    if !test("[ -w #{fetch(:deploy_to)}/shared ]")
      execute("mkdir #{fetch(:deploy_to)}/shared")
    end
  end
end
