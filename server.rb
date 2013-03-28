# RestKit Sinatra Testing Server
# Place at RoadNinjaTests/server.rb and run with `ruby RoadNinjaTests/server.rb` before executing the test suite within Xcode

require 'rubygems'
require 'sinatra'
require 'json'

puts "This is process #{Process.pid}"

configure do
    set :logging, true
    set :dump_errors, true
    set :public_folder, Proc.new { File.expand_path(File.join(root, 'Fixtures')) }
end

def render_fixture(filename)
    send_file File.join(settings.public_folder, filename)
end

post "/1/locations/:poi_id/reviews/create.json" do
    content_type :json
    jdata = {:author => params[:author],
             :text => params[:text],
             :rating => params[:rating].to_i,
             :id => '50f9ec0dac0cfe2db5000003',
             :image => 'https://www.ishimr2013.com/sites/default/files/Reviews_Icon_ISHIMR_2013_v3.jpg'}.to_json
end

get "/3/venues/:poi_id/reviews" do
    render_fixture('ReviewMany.json')
end

# Creates a route that will match /3/places/exit?exitId=<exit ID>
get '/3/places/exit' do
    render_fixture('ExitsPoiMany.json')
end

# Creates a route that will match /3/venues/exit?exitId=<exit ID>
get '/3/venues/exit' do
    render_fixture('ExitsPoiMany.json')
end


# Creates a route that will match /3/venues/location?&latlng=<lat>,<long>
get '/3/venues/location' do
    render_fixture('ExitsPoiMany.json')
end

# Creates a route that will match /articles/<category name>/<article ID>
#get '/articles/:category/:id' do
#    render_fixture('article.json')
#end

# Return a 503 response to test error conditions
get '/offline' do
    status 503
end

# Simulate a JSON error
get '/error' do
    status 400
    content_type 'application/json'
    "{f36a311cba6c29ba4c54f0b8c76e6cb733c01e65quot;errorf36a311cba6c29ba4c54f0b8c76e6cb733c01e65quot;: f36a311cba6c29ba4c54f0b8c76e6cb733c01e65quot;An error occurred!!f36a311cba6c29ba4c54f0b8c76e6cb733c01e65quot;}"
end