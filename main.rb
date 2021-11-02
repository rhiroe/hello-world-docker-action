require 'octokit'

github_token, repo, current_branch, release_branch_regexp, title, body = ARGV

# テスト
puts current_branch

client = Octokit::Client.new(access_token: github_token)

all_branches = []
loop.with_index(1) do |_, page|
  branches = client.branches(repo, per_page: 100, page: page).map(&:name)
  break if branches.size == 0

  all_branches += branches
end

release_branches = all_branches.select { |branch_name| branch_name.match?(release_branch_regexp) }

if release_branches.include? current_branch
  to_branch = release_branches.find { |b| b > current_branch } || client.repo(repo).default_branch
  client.create_pull_request(repo, to_branch, current_branch, title, body)
end
