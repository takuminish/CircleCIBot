require 'sinatra'
require 'rack/contrib'
require 'json'
require 'dotenv'
require './payload.rb'

use Rack::PostBodyContentTypeParser

Dotenv.load

get '/' do

end

post '/' do

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
    payload = Payload.new(1,2,3,4,5,6,7,8,ENV["WEBHOOKURL"])
    payload.post

end
