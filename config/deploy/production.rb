
#FIXME replace 1.2.3.4 with your IP address
server '100.25.177.176', user: 'deploy', roles: %w{web app db}
set :rails_env, 'production'