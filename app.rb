require 'sinatra'
require 'rack/contrib'


use Rack::PostBodyContentTypeParser

get '/' do
    'Hello'
end

post '/' do
    "#{params}"
end