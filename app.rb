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
=begin
    payload = Payload.new(params['payload']['reponame'],
                          params['payload']['outcome'],
                          params['payload']['branch'],
                          params['payload']['committer_name'],
                          params['payload']['subject'],
                          params['payload']['all_commit_details'][0]['commit_url'],
                          params['payload']['build_url'],
                          params['payload']['build_num'],
                          uri)
=end
    payload = Payload.new("a","b","c","d","e","f","g",uri)
    payload.log

   
   Net::HTTP.post_form(uri, {payload: payload.to_json})

end
