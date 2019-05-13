require 'sinatra'
require 'rack/contrib'
require 'json'
require 'net/http'
require 'dotenv'
require 'uri'

use Rack::PostBodyContentTypeParser

Dotenv.load

get '/' do

end

post '/' do
   puts params['payload']['all_commit_details'][0]['commit_url']

   #puts params[:payload][:outcome]
   #puts params[:payload][:committer_name]
   #puts params[:payload][:subject]
   #puts params[:payload][:reponame]
   #puts params[:payload][:branch]
   #puts params[:payload][:build_url]
   #puts params[:payload][:commit_url]
   
   uri = URI.parse(ENV["WEBHOOKURL"])
   
   color = "good"
   pretext = "テストが成功しましたわ!!"

   if params['payload']['outcome'] === "failed"
    color = "danger" 
    pretext = "テストを失敗するなんてブッブーですわ!!"
   end
   payload = {
       attachments: [
           {
               title: "#{params['payload']['reponame']} CircleCI結果",
               pretext: pretext,
               text: params['payload']['outcome'],
               fields: [
                {
                    title: "branch",
                    value: params['payload']['branch'],
                    short: "true"
               },
                {
                    title: "committer_name",
                    value: params['payload']['committer_name'],
                    short: "true"
               },
               {
                    title: "commit_url",
                    value: "<#{params['payload']['all_commit_details']['commit_url']} | #{params['payload']['subject']} >",
                    short: "true"
               },
               {
                    title: "build_url",
                    value: "<#{params['payload']['build_url']} | ##{params['payload']['build_num']} >",
                    short: "true"
                }
               ],
               color: color
           }
       ]
   }

   Net::HTTP.post_form(uri, {payload: payload.to_json})

end
