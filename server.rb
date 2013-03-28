# RestKit Sinatra Testing Server
# Place at RoadNinjaTests/server.rb and run with `ruby RoadNinjaTests/server.rb` before executing the test suite within Xcode

require 'rubygems'
require 'sinatra'
require 'sinatra/namespace'
require 'yaml'
require 'json'

puts "This is process #{Process.pid}"

configure do
  set :environment, :development
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

namespace '/api' do
  namespace '/users' do
    
    get '/:id/recommendations' do
      content_type 'application/json'
      data = load_fixture("users_recommendations.yml")
      { 
        :products => data['products'],
        :categories => data['categories'][page],
        :colors => data['colors'][page]
      }.to_json
    end

    get '/:id/products/recent' do
      content_type 'application/json'
      load_fixture("users_products_recent.yml")[page].to_json
    end

    get '/:id/products/search' do
      content_type 'application/json'
      load_fixture("users_products_search.yml")[page].to_json
    end

    get '/:id/products/add' do
      status 201
    end

    delete '/:id/products/:product_id/delete' do
      status 200
    end

    get '/anonymous' do
      content_type 'application/json'
      load_fixture("users_anonymous.yml").to_json
    end

    get '/authenticate' do
      content_type 'application/json'
      load_fixture("users_authenticate.yml").to_json
    end
  end
  get '/products/search' do
    content_type 'application/json'
    load_fixture("products_search.yml")[page].to_json
  end
end
