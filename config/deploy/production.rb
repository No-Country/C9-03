
#FIXME replace 1.2.3.4 with your IP address
server '3.222.22.62', user: 'deploy', roles: %w{app db web}
set :rails_env, 'production'