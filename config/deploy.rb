# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'Mentorship'
set :repo_url, 'git@github.com:riskmethods/Mentorship.git'
set :deploy_to, '/home/riskmethods/Mentorship'
set :asset_roles, [:web]
