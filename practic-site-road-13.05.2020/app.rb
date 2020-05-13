require 'roda'
require_relative 'lib/triangle_list.rb'
require_relative 'lib/triangle.rb'
require_relative 'lib/input_validators.rb'
class App < Roda
    opts[:root] = __dir__
    plugin :environments
    plugin :render
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
            r.redirect "//"
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
                @params = InputValidators.check_min_and_max(r.params['min'], r.params['max'])
                pp @params[:error]
                @filter_triangle = if @params[:error].empty?
                                        opts[:index].triangles_by_area(@params[:min], @params[:max])
                                    else  
                                        opts[:index].all_triangle
                                    end
                view('index')
            end
            r.on "new" do
                r.get do
                    view('triangle_new')
                  end
                r.post do
                    @params = InputValidators.check_side_lengths(r.params['line_one'],
                        r.params['line_two'], r.params['line_three'])
                    pp @params[:error]
                    if @params[:error].empty?
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