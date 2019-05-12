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
   #puts params

   puts params[:payload][:outcome]
   puts params[:payload][:committer_name]
   puts params[:payload][:subject]
   puts params[:payload][:reponame]
   puts params[:payload][:branch]
   puts params[:payload][:build_url]
   puts params[:payload][:commit_url]
   
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
               title: "#{params[:payload][:reponame]} CircleCI結果"
               pretext: pretext,
               text: params[:payload][:outcome],
               Fields: [
                {
                    title: "branch",
                    text: params[:payload][:branch]
               },
                   {
                        title: "committer_name",
                        text: params[:payload][:committer_name]
                   },
                   {
                        title: "commit_url",
                        text: "<#{params[:payload][:commit_url]} | #{params[:payload][:subject]} >"
                   },
                   {
                    title: "build_url",
                    text: "<#{params[:payload][:build_url]} | ##{params[:payload][:build_num]} >"
               },
               ],
               color: color
           }
       ]
   }

   Net::HTTP.post_form(uri, {payload: payload.to_json})

end
