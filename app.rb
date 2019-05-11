require 'sinatra'
require 'rack/contrib'
require 'json'
require 'net/http'
require 'dotenv'
require 'uri'


use Rack::PostBodyContentTypeParser
Dotenv.load

get '/' do
    p "#{params}"
end

post '/' do
   puts params[:payload]
   
   uri = URI.parse(ENV["WEBHOOKURL"])

   payload = {
       attachments: [
           {
               text: "#{params}",
               color: "good"
           }
       ]
   }

   Net::HTTP.post_form(uri, {payload: payload.to_json})

end