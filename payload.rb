class Payload
    def initialize(reponame, pretext, outcome, branch, commiter_name, commit_url, build_url, webhook_uri)
        @reponame = reponame
        @pretext = pretext
        @outcome = outcome
        @branch = branch
        @commiter_name = commiter_name
        @commit_url = commit_url
        @build_url = build_url
        @webhook_uri = webhook_uri

    end

    def post

    end


end