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
   
   color = "good"
   if params[:payload][:outcome] === "failed"
    color = "danger" 
   end
   payload = {
       attachments: [
           {
               text: "#{params[:payload][:outcome]}",
               color: color
           }
       ]
   }

   Net::HTTP.post_form(uri, {payload: payload.to_json})

end