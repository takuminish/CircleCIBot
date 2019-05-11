require 'sinatra'
require 'rack/contrib'
require 'json'


use Rack::PostBodyContentTypeParser

get '/' do
    p "#{params}"
end

post '/' do
   puts params["id"]
   puts params[:id]
end