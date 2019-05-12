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

   puts params[:payload][:outcome]
   puts params[:payload][:commiter_name]
   puts params[:payload][:subject]
   puts params[:payload][:repo_name]
   puts params[:payload][:branch]
   puts params[:payload][:build_url]
   
   uri = URI.parse(ENV["WEBHOOKURL"])
   
   color = "good"
   pretext = "テストが成功しましたわ!!"

   if params[:payload][:outcome] === "failed"
    color = "danger" 
    pretext = "テストを失敗するなんてブッブーですわ!!"
   end
   payload = {
       attachments: [
           {
               pretext: pretext,
               text: "#{params[:payload][:outcome]}",
               color: color
           }
       ]
   }

   Net::HTTP.post_form(uri, {payload: payload.to_json})

end