class HomeController < ApplicationController
  def index
    # I'll be the default if no username was passed
    #TODO: Add a notice if no username was passed
    params[:username] ||= 'excid3'
    
    list = Net::HTTP.get URI.parse("http://github.com/api/v2/yaml/repos/show/#{params[:username]}")
    @repos = YAML::load(list)["repositories"]
    
    # Make sure each repo has some value for when it was last pushed
    @repos.each do |repo|
      if !repo.has_key? :pushed_at
        # Repos that don't have a pushed_at can just be sorted by created_at
        repo[:pushed_at] = repo[:created_at]
      end
    end
    
    # Repos are sorted by last pushed_at
    @repos.sort! { |a, b| a[:pushed_at] <=> b[:pushed_at] }
  end
end
