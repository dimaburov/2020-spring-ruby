require 'roda'
require 'date'
require 'forme'

require_relative 'models.rb'
# The core class of the web application for managing tests
class App < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render
  plugin :forme
  plugin :status_handler
  configure :development do
    plugin :public
    opts[:serve_static] = true
  end
  opts[:landings] = LandingList.new(
    [
        Landing.new(
            id: 12,
            type: 'Посадка',
            name: 'Морковь',
            scope: 31.2,
            unit: 'Грядка',
            description: 'Описание',
            landing_date: Date.parse('2011-01-18')
        ),
        Landing.new(
            id: 2,
            type: "Подготовка почвы",
            name: 'Свекла',
            scope: 12.3,
            unit: 'Ряд',
            description: 'Крутая свекла',
            landing_date: Date.parse('2012-02-14')
        )
    ]
  )
    status_handler(404) do
        view('not_found')
    end
  route do |r|
    r.public if opts[:serve_static]
    r.root do
      r.redirect '/region'
    end
    r.on 'region' do
        opts[:landings].landings_sort_by_date
        r.is do
            @landings = opts[:landings].all_landings
            view('landings')
        end
        r.on Integer do |landing_id|
            @landing = opts[:landings].lading_by_id(landing_id)
            next if @landing.nil?
            r.is do
                view('landing')
            end
            r.on 'edit' do
                r.get do
                  @parameters = @landing.to_h
                  view('landing_edit')
                end
      
                r.post do
                  @parameters = DryResultFormeWrapper.new(LandingFormSchema.call(r.params))
                  if @parameters.success?
                    opts[:landings].update_landing(@landing.id, @parameters)
                    r.redirect "/region/#{@landing.id}"
                  else
                    view('landing_edit')
                  end
                end
            end
            r.on 'delete' do
                r.get do
                  @parameters = {}
                  view('landing_delete')
                end
      
                r.post do
                  @parameters = DryResultFormeWrapper.new(LandingDeleteSchema.call(r.params))
                  if @parameters.success?
                    opts[:landings].delete_landing(@landing.id)
                    p "YEs!!!!!!!!!!"
                    r.redirect('/region')
                  else
                    view('landing_delete')
                  end
                end
            end
        end
        r.on 'new' do
            r.get do
              @parameters = {}
              view('landing_new')
            end
    
            r.post do
              @parameters = DryResultFormeWrapper.new(LandingFormSchema.call(r.params))
              if @parameters.success?
                lading_id = opts[:landings].add_landing(@parameters)
                r.redirect "/region/#{lading_id}"
              else
                view('landing_new')
              end
            end
          end
    end 
  end
end