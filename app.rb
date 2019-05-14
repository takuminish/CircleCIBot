require 'sinatra'
require 'rack/contrib'
require 'json'
require 'net/http'
require 'dotenv'
require 'uri'
require './payload.rb'

use Rack::PostBodyContentTypeParser

Dotenv.load

get '/' do

end

post '/' do

    #puts params

    uri = URI.parse(ENV["WEBHOOKURL"])

    payload = Payload.new(params['payload']['reponame'],
                          params['payload']['outcome'],
                          params['payload']['branch'],
                          params['payload']['committer_name'],
                          params['payload']['subject'],
                          params['payload']['all_commit_details'][0]['commit_url'],
                          params['payload']['build_url'],
                          uri)
    payload.log
   
   
   color = "good"
   pretext = "テストが成功しましたわ!!"
   thumb_url = "./img/success.jpg"

   if params['payload']['outcome'] === "failed"
    color = "danger" 
    pretext = "テストを失敗するなんてブッブーですわ!!"
    thumb_url = "./img/field.jpg"

   end
   payload = {
       attachments: [
           {
               
               title: "#{params['payload']['reponame']} CircleCI結果",
               thumb_url: thumb_url,
               pretext: "<!channel> #{pretext}",
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
                    value: "<#{params['payload']['all_commit_details'][0]['commit_url']} | #{params['payload']['subject']} >",
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
