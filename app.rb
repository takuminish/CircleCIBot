require 'sinatra'
require 'rack/contrib'


use Rack::PostBodyContentTypeParser

get '/' do
    p "#{params}"
end

post '/' do
   p "#{params}"
end