# config valid for current version and patch releases of Capistrano
lock "3.16.0"

set :application, "Quartet"
set :deploy_to, '/var/www/Quartet'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:keita0724/Quartet.git'

set :branch, 'main'

set :linked_files, fetch(:linked_files, []).push('config/settings.yml')

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# 保持するバージョンの個数(※後述)
set :keep_releases, 5

# rubyのバージョン
set :rbenv_type, :user
set :rbenv_ruby, '2.6.6'
# set :rbenv_custom_path, '/root/.rbenv'

set :ssh_options, auth_methods: ['publickey'], keys: ['~/.ssh/Key_Q1.pem']

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }

# after 'deploy:publishing', 'deploy:restart'
# namespace :deploy do
#   task :restart do
#     invoke 'unicorn:restart'
#   end
# end

namespace :deploy do
#   desc "Initialize application"
#   task :initialize do
#     invoke 'composing:build'
#     invoke 'composing:database:up'
#     invoke 'composing:database:create'
#     invoke 'composing:database:migrate'
#   end

  after :published, :restart do
    invoke 'composing:restart:web'
    invoke 'composing:database:migrate'
  end

#   before :finished, :clear_containers do
#     on roles(:app) do
#       execute "docker ps -a -q -f status=exited | xargs -r docker rm -v"
#       execute "docker images -f dangling=true -q | xargs -r docker rmi -f"
#     end
#   end
end