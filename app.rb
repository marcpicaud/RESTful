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

get '/' do
  status 200
end

get '/users/:id' do
  user = User.find_by_id(params[:id])
  if user.nil?
    content_type :json
    {:status => 404, :message => 'not found' }.to_json
  elsif user[:role] == 'admin'
    content_type :json
    {:status => 401, :message => 'not found' }.to_json
  else
    user.to_json(:except => [:password])
  end
end
