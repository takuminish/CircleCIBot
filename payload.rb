require 'net/http'
require 'uri'

class Payload
    def initialize(reponame, outcome, branch, commiter_name, commit_message, commit_url, build_url, build_num, webhook_url)
        @reponame = reponame
        @outcome = outcome
        @branch = branch
        @commiter_name = commiter_name
        @commit_message = commit_message
        @commit_url = commit_url
        @build_url = build_url
        @build_num = build_num
        @webhook_uri = URI.parse(webhook_url)
        @color = "good"
        @pretext = "テストが成功しましたわ!!"
        if @outcome === "failed"
            @color = "danger" 
            @pretext = "テストを失敗するなんてブッブーですわ!!"
        end

    end

    def post
        @post_data = {
            attachments: [
                {
                    
                    title: "#{@title} CircleCI結果",
                    pretext: "<!channel> #{@pretext}",
                    text: @outcome,
                    fields: [
                     {
                         title: "branch",
                         value: @branch,
                         short: "true"
                    },
                     {
                         title: "committer_name",
                         value: @commiter_name,
                         short: "true"
                    },
                    {
                         title: "commit_url",
                         value: "<#{@commit_url} | #{@commit_message} >",
                         short: "true"
                    },
                    {
                         title: "build_url",
                         value: "<#{@build_url} | ##{@build_num} >",
                         short: "true"
                     }
                    ],
                    color: @color
                }
            ]
        }
        self.log
        Net::HTTP.post_form(@webhook_uri, {payload: @post_data.to_json})
    end

    def log
        puts "reponame: #{@reponame}"
        puts "outcome: #{@outcome}"
        puts "branch: #{@branch}"
        puts "commiter_name: #{@commiter_name}"
        puts "commit_message: #{@commit_message}"
        puts "commit_url: #{@commit_url}"
        puts "build_url: #{@build_url}"
        puts "webhook_uri: #{@webhook_uri}"
        puts @post_data
    end


end