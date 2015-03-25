require 'sinatra'
require 'active_record'
require 'mysql2'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "root",
  :password => "sagemmy-x5",
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

delete '/user/:id' do
  content_type :json
  User.find_by_id(params[:id]).destroy
end

post '/users' do
  content_type :json
  {"params" => params}.to_json
  begin
    user = User.create(
      :lastname => params[:lastname],
      :firstname => params[:firstname],
      :email => params[:email],
      :password => params[:password],
      :role => params[:role]
    )
  rescue
    "ERROR!".to_json
  end
  #user.to_json
end

put '/users/:id' do
  #content_type :json
  my_user = User.find_by_id(params[:id])
  wanted = %w[lastname firstname email password role]
  puts params.inspect
  #params.each do |k, v|
    #if k.class == String and wanted.include? k
     # begin
      #  k.inspect
       # v.inspect
        #my_user[k] = v
      #rescue
      #end
    #end
    #puts k.inspect
    #puts v.inspect
  #end
end
