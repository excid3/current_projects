class HomeController < ApplicationController
  def index
    list = Net::HTTP.get URI.parse('http://github.com/api/v2/yaml/repos/show/excid3')
    @repos = YAML::load(list)["repositories"].sort { |a, b| a[:pushed_at] <=> b[:pushed_at] }
  end
end
