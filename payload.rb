class Payload
    def initialize(reponame, outcome, branch, commiter_name, commit_message, commit_url, build_url, webhook_uri)
        @reponame = reponame
        @outcome = outcome
        @branch = branch
        @commiter_name = commiter_name
        @commit_message = commit_message
        @commit_url = commit_url
        @build_url = build_url
        @webhook_uri = webhook_uri

    end

    def post

    end

    def log
        puts @reponame
        puts @outcome
        puts @branch
        puts @commiter_name
        puts @commit_message
        puts @commit_url
        puts @build_url
        puts @webhook_uri
    end


end