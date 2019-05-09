require 'sinatra'

use Rack::PostBodyContentTypeParser

get '/' do
    'Hello'
end

post '/' do
    "#{params}"
end