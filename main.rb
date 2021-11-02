require 'octokit'

github_token, repo, release_branch_regexp, title, body = ARGV

client = Octokit::Client.new(access_token: github_token)
all_branches = []
loop.with_index(1) do |_, page|
  branches = client.branches(repo, per_page: 100, page: page)
  break if branches.size == 0

  all_branches += branches
end

release_branches = all_branches.select { |b| b.name.match?(release_branch_regexp) }.map(&:name)
default_branch = client.repo(repo).default_branch
release_branches << default_branch

release_branches.each_cons(2) do |from_branch, to_branch|
  retry_counter = 0
  begin
    sleep 3
    client.create_pull_request(repo, to_branch, from_branch, title, body)
  rescue Octokit::BadGateway, Faraday::ConnectionFailed
    retry_counter += 1
    retry if retry_counter < 3
  rescue Octokit::UnprocessableEntity => e
    puts e.message
  end
end
