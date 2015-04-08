require 'sinatra'
require 'json'
require 'active_record'
require 'mysql2'
require 'sinatra/param'
require './rest'

set :run, true
set :bind, '0.0.0.0'
set :environment, :development
set :show_exceptions, :after_handler
set :raise_sinatra_param_exceptions, true

error Sinatra::Param::InvalidParameterError do
  {error: "#{env['sinatra.error'].param} is invalid"}.to_json
end

ActiveRecord::Base.establish_connection(
    :adapter => "mysql2",
    :host => "localhost",
    :username => "root",
    :password => "root",
    :database => "rest"
)

vip = User.all.to_a.map(&:serializable_hash)

use Rack::Auth::Basic, "Restricted Area" do |email, password|
  Digest::SHA1.hexdigets(password) == vip[:users][username][:password]
  password.to_s == vip[email.to_sym][:password]
end



run App