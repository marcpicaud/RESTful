class User < ActiveRecord::Base
end

class App < Sinatra::Base
  helpers Sinatra::Param

  before do
    content_type :json
  end

  get '/' do
    status 200
  end

  get '/users/:id' do
    param :id, Integer, max: 2147483647, min: -2147483648

    user = User.find_by_id(params[:id])

    if user.nil?
      status 404
      {:status => 404, :message => 'not found'}.to_json
    elsif user[:role] == 'admin'
      status 401
    else
      user.to_json(:except => [:password])
    end
  end

  get '/user/:id' do
    param :id, Integer, max: 2147483647, min: -2147483648

    user = User.find_by_id(params[:id])

    if user.nil?
      status 404
      {:status => 404, :message => 'not found'}.to_json
    elsif user[:role] == 'admin'
      status 401
    else
      user.to_json(:except => [:password])
    end
  end

  get '/search/users' do
    param :q, String, required: true

    users = User.where(email: params[:q])
    if users.blank?
      status 404
    else
      users.to_json
    end
  end

  delete '/users/:id' do
    param :id, Integer, max: 2147483647, min: -2147483648

    begin
      user = User.find_by_id(params[:id])
      user.destroy
    rescue
      return status 500
    end
  end

  post '/users/?' do
    request.body.rewind
    data = JSON.parse request.body.read
    begin
      user = User.create(data)
      return status 201
    rescue
      return status 400
    end
  end

  put '/users/:id?' do
    param :id, Integer, required: true, max: 2147483647, min: -2147483648

    request.body.rewind
    data = JSON.parse request.body.read

    begin
      user = User.find_by_id(params[:id])
      user.update_all(data)
    rescue
      return status 400
    end



  end
end
