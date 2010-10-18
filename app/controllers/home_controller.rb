class HomeController < ApplicationController
  def index
    params[:username] ||= 'excid3'
    url = "http://github.com/api/v2/yaml/repos/show/#{params[:username]}"
    list = Net::HTTP.get URI.parse(url)
    @repos = YAML::load(list)["repositories"].sort { |a, b| a[:pushed_at] <=> b[:pushed_at] }
  end
end
