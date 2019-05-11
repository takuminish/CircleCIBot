require 'sinatra'
require 'rack/contrib'
require 'json'
require 'http'
require 'uri'


use Rack::PostBodyContentTypeParser

get '/' do
    p "#{params}"
end

post '/' do
   puts params[:payload]


end