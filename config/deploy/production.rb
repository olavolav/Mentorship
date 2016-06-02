set :stage, :production
set :rails_env, :production
set :user, 'riskmethods'

server '136.243.174.217', roles: [:app, :db, :web], primary: true
