require 'sinatra'
require 'rack/contrib'
require 'json'
require 'http'
require 'dotenv'


use Rack::PostBodyContentTypeParser

get '/' do
    p "#{params}"
end

post '/' do
   puts params[:status]
   
   uri = URI.parse(ENV["WEBHOOKURL"])
   payload = {
       attachments: [
           {
               text: params[:status],
               color: "good"
           }
       ]
   }

   Net::HTTP.post_form(uri, {payload: payload.to_json})

end