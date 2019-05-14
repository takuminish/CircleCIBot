require 'sinatra'
require 'rack/contrib'
require 'json'
require 'dotenv'
require 'uri'
require './payload.rb'

use Rack::PostBodyContentTypeParser

Dotenv.load

get '/' do

end

post '/' do

    uri = URI.parse(ENV["WEBHOOKURL"])

    payload = Payload.new(params['payload']['reponame'],
                          params['payload']['outcome'],
                          params['payload']['branch'],
                          params['payload']['committer_name'],
                          params['payload']['subject'],
                          params['payload']['all_commit_details'][0]['commit_url'],
                          params['payload']['build_url'],
                          params['payload']['build_num'],
                          uri)
    payload.post

end
