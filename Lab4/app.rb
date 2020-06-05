# frozen_string_literal: true

require 'roda'
require 'date'
require 'time'
require 'forme'

require_relative 'models.rb'
# The core class of the web application for managing tests
class App < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
  plugin :hash_routes
  plugin :path
  plugin :render
  plugin :status_handler
  plugin :view_options
  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  require_relative 'routes/trains.rb'
  require_relative 'routes/cities.rb'

  opts[:store] = Store.new
  opts[:trains] = opts[:store].train_list

  status_handler(404) do
    view('not_found')
  end

  route do |r|
    r.public if opts[:serve_static]
    r.hash_branches
    r.root do
      r.redirect '/trains'
    end
  end
end
