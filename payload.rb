class Payload
    def initialize(reponame, pretext, outcome, branch, commiter_name, commit_url, build_url, webhook_url)
        @reponame = reponame
        @pretext = pretext
        @outcome = outcome
        @branch = branch
        @commiter_name = commiter_name
        @commit_url = commit_url
        @build_url = build_url
        @webhook_url = webhook_url

    end

    def post

    end


end