require 'sinatra'
require 'json'
require 'dotenv'
require './payload.rb'

Dotenv.load

get '/' do

end

post '/' do

    params = JSON.parse request.body.read
    
    payload = Payload.new(params['payload']['reponame'],
                          params['payload']['outcome'],
                          params['payload']['branch'],
                          params['payload']['committer_name'],
                          params['payload']['subject'],
                          params['payload']['all_commit_details'][0]['commit_url'],
                          params['payload']['build_url'],
                          params['payload']['build_num'],
                          uri)

end
