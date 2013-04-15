# RestKit Sinatra Testing Server
# Place at RoadNinjaTests/server.rb and run with `ruby RoadNinjaTests/server.rb` before executing the test suite within Xcode

require 'rubygems'
require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/cookies'
require 'yaml'
require 'json'

puts "This is process #{Process.pid}"

configure do
  set :logging, true
  set :dump_errors, true
  set :public_folder, Proc.new { File.expand_path(File.join(root, 'Fixtures')) }
end

def load_fixture(filename)
  YAML.load_file(File.join(settings.public_folder, filename))
end

def page
  params[:page].nil? ? 0 : params[:page].to_i - 1 
end

before /.*/ do
  if request.path_info !~ /authorize/ && (cookies[:_rately_session].nil? || cookies[:_rately_session].length == 0)
    halt 401
  end
end

namespace '/api' do
  namespace '/users' do

    post '/authorize' do
      content_type 'application/json'
      cookies[:_rately_session] = '_rately_session_key_'
      load_fixture("users_authorize.yml").to_json
    end
    
    get '/:id/recommendations' do
      content_type 'application/json'
      data = load_fixture("users_recommendations.yml")
      { 
        :categories => data['categories'][page],
        :colors => data['colors'][page],
        :pagination => data['pagination']
      }.to_json
    end

    get '/:id/products/recent' do
      content_type 'application/json'
      fixture = load_fixture("users_products_recent.yml")
      {:products => fixture['products'][page], :pagination => fixture['pagination']}.to_json
    end

    post '/:id/products/search' do
      content_type 'application/json'
      fixture = load_fixture("users_products_search.yml")
      {:products => fixture['products'][page], :pagination => fixture['pagination']}.to_json
    end

    post '/:id/products' do
      status 201
    end

    delete '/:id/products/:product_id' do
      status 200
    end

  end

  post '/products/search' do
    content_type 'application/json'
    fixture = load_fixture("products_search.yml")
    {:products => fixture['products'][page], :pagination => fixture['pagination']}.to_json
  end

end
