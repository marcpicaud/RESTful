require 'sinatra'
require 'active_record'
require 'mysql2'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "root",
  :password => "root",
  :database => "rest"
)

class User < ActiveRecord::Base
end

set :bind, '0.0.0.0'

error do
  status 500
end

get '/search/users' do
  mail = params[:q]
  User.where(email = mail).to_json
end
