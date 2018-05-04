require 'faraday'
require 'json'
require 'pry'

class UserRepositories

  def initialize(username)
    @username = username
  end

#connect to github
  def github_url
    "https://api.github.com/users/#{@username}/repos"
  end

#pass api response as an object
  def get_api_data
    response = Faraday.get(github_url)
    data = JSON.parse(response.body)
  end

  # this method collects the names of all the repos for that username
  def collect_data
    data = get_api_data
    repos_name_data = collect_repos_names(data)
    # repos_language_data = collect_language_history(repos_name_data)

  end

end

private

# this method saves all the repos names in the array all names.
def collect_repos_names(data)
    data.collect do |repos_names|
    repos_names['name']
    end
end

def collect_language_history(repos_name_data)
  repos_name_data.collect do |name|
    name['language'].collect
  end
end


def github_repo_language_url
  "https://api.github.com/repos/#{@username}/#{@repo_name}/languages"
end

user = UserRepositories.new('TessaReed')
puts user.collect_data
