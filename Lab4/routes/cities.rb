# frozen_string_literal: true

# Routes for the cool cities of this application
class App
  path :cities_all, '/cities/all_cities'
  path :cities_live, '/cities/live_the_city'
  path :cities_max, '/cities/max_path'

  hash_branch('cities') do |r|
    append_view_subdir('cities')
    set_layout_options(template: '../views/layout')

    r.on 'live_the_city' do
      r.get do
        @cities = opts[:trains].check_live_city
        view('live_the_city')
      end
    end

    r.on 'all_cities' do
      r.get do
        @cities = opts[:trains].all_cities
        view('all_cities')
      end
    end

    r.on 'max_path' do
      r.get do
        @parameters = DryResultFormeWrapper.new(MaxPathFormSchema.call(r.params))
        @max_path = if @parameters.success?
                      opts[:trains].max_path(@parameters)
                    else
                      @max_path = 0
                    end
        view('number_of_path')
      end
    end
  end
end
