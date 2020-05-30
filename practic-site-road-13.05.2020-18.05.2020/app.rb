require 'roda'
require 'forme'

require_relative 'lib/triangle_list.rb'
require_relative 'lib/triangle.rb'
require_relative 'lib/input_validators.rb'
require_relative 'lib/dry_result_forme_adapter.rb'
require_relative 'lib/new_test_form_shenema.rb'
require_relative 'lib/test_filter_for_shenema.rb'
class App < Roda
    opts[:root] = __dir__
    plugin :environments
    plugin :render
    plugin :forme
    configure :development do
        plugin :public
        opts[:serve_static] = true
    end
    opts[:index] = TriangleList.new([
        Triangle.new(3, 4, 5),
        Triangle.new(5, 12, 13),
        Triangle.new(1, 2, 3)
    ])
    route do |r|
        r.public if opts[:serve_static]
        r.root do
            r.redirect "triangles"
        end
        # /
        r.on "/" do
            @greeting = '<meta charset="UTF-8"> Маршрут работает'
            r.get "world" do
                "#{@greeting} world!"
              end
            r.is do
                # GET /  request

                r.get do
                    "#{@greeting}"
                end
                # POST /  request
                r.post do
                    puts "#{@greeting}"
                    r.redirect
                end
            end
        end
        r.on "triangles" do
            r.is do
                @params = DryResultFormeAdapter.new(TestFormSchema.call(r.params))
                @filter_triangle = if @params.success?
                                        opts[:index].triangles_by_area(@params[:min], @params[:max])
                                    else  
                                        opts[:index].all_triangle
                                    end
                view('index')
            end
            r.on "new" do
                r.get do
                    @params = {}
                    view('triangle_new')
                  end
                r.post do
                    @params = DryResultFormeAdapter.new(NewTestFormSchema.call(r.params))
                    if @params.success?
                        opts[:index].add_triangle(Triangle.new(@params[:line_one], @params[:line_two], @params[:line_three]))
                        r.redirect '/triangles'
                    else
                        view('triangle_new')
                    end
                end
            end
        end

    end
end