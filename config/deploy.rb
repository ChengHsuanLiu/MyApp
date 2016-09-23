# config valid only for current version of Capistrano
lock '3.5.0'

set :application,     'MyApp'

# for private repo setting
# 1. add public key to github ssh keys (usually at ~/.ssh/id_rsa.pub)
# 2. check 'ssh -T git@github.com' on local machine, which will reponse:
#      Hi username! You've successfully authenticated, but GitHub does not provide shell access
# 3. run 'cap {ENVIRONMENT} deploy:check' to check if it works
# 4. if changing repo_url, you need also clean the repo directory on remote server (rm -rf ~/APP_NAME/repo)
#
# refs:
#   http://stackoverflow.com/questions/22736392/capistrano-deply-not-finding-private-github-repo-key-forwarding-working
#   http://stackoverflow.com/questions/35256942/fatal-authentication-failed-error-when-deploying-private-repo

set :repo_url,        'git@github.com:ChengHsuanLiu/MyApp.git'
set :scm,             :git
set :user,            'deploy'

set :pty,             false
set :use_sudo,        false

set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"

set :ssh_options,     { forward_agent: true, user: fetch(:user) }

set :rvm_type, :auto
set :rvm_ruby_version, '2.3.1'

set :bundle_jobs, 4
set :bundle_env_variables, { nokogiri_use_system_libraries: 1 }

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs,  fetch(:linked_dirs,  []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

set :keep_releases, 5

namespace :bundler do
  before :install, :prepare_bundle do
    on roles(:web) do
      execute :bundle, "config build.nokogiri --use-system-libraries=true --with-xml2-include=/usr/include/libxml2"
    end
  end
end
