require "roda"


class App < Roda
  route do |r|
    # GET / request
    r.root do
      r.redirect "/hello"
    end

    # /hello branch
    r.on "hello" do
      # Set variable for all routes in /hello branch
      @greeting = '<meta charset="UTF-8"> Здравствуйте'

      # GET /hello/world request
      r.get "world" do
        "#{@greeting} world!"
      end

      # /hello request
      r.is do
        # GET /hello request
        r.get do
          "#{@greeting}!"
        end

        # POST /hello request
        r.post do
          puts "Someone said #{@greeting}!"
          r.redirect
        end
      end
    end
        r.on "get" do         
          r.is "rng" do       
            r.get do
                "#{rand 100..5000}"
            end    
            r.post do end   
          end
          # GET /get/sophisticated/rng  
          r.on "sophisticated/rng" do
            if(r.params["min"] == nil)
                return "Min not found"  
            end
            if(r.params["max"] == nil)
                return "Max not found"
            end
            begin
                return "#{rand r.params['min'].to_f..r.params['max'].to_f}"
            rescue
                return "ERROR"
            end
          end 
        end

   # GET /cool/hello/NAME/SURNAME
   r.get "cool", "hellow", String, String do |name, surname|
    "Hellow, #{name} #{surname}" 
  end
   # GET /calc/min/NUM_ONE/NUM_TWO
   r.get "calc", "min", String, String do |num_one, num_two|
    if num_one.to_i<num_two.to_i then "min: #{num_one}" 
    else  "min: #{num_two}" 
    end
  end
  # GET /calc/multiply/NUM_ONE/NUM_TWO
  r.get "calc", "multiply", String, String do |num_one, num_two|
    "Num: #{num_one.to_f*num_two.to_f}"
  end 
end
end