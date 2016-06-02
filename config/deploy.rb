# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'Mentorship'
set :repo_url, 'git@github.com:riskmethods/Mentorship.git'
set :deploy_to, '/home/riskmethods/Mentorship'
set :asset_roles, [:web]
set :unicorn_rack_env, 'production'
set :linked_dirs, fetch(:linked_dirs, []).push('tmp', 'log', 'public/assets')

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
