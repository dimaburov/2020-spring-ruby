# frozen_string_literal: true

# Routes for the cool train of this application
class App
  path :trains, '/trains'
  path :trains_filter, '/trains/filter'
  path :trains_new, '/trains/new'

  path Train do |train, action|
    if action
      "/trains/#{train.id}/#{action}"
    else
      "/trains/#{train.id}"
    end
  end

  hash_branch('trains') do |r|
    append_view_subdir('trains')
    set_layout_options(template: '../views/layout')

    r.is do
      @parameters = DryResultFormeWrapper.new(DateIntervalFormSchema.call(r.params))
      @trains = if @parameters.success?
                  opts[:trains].filter_interval_date(@parameters)
                else
                  opts[:trains].all_trains
                end
      view('day_interval')
    end

    r.on Integer do |train_id|
      @trains = opts[:trains].trains_by_id(train_id)
      next if @trains.nil?

      r.on 'day_interval' do
        view('information_train_day_interval')
      end

      r.on 'full_filter' do
        view('information_train_full_filter')
      end

      r.on 'delete' do
        r.get do
          @parameters = {}
          view('train_delete')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(TrainDeleteSchema.call(r.params))
          if @parameters.success?
            opts[:trains].delete_trains(@trains.id)
            r.redirect(trains_path)
          else
            view('train_delete')
          end
        end
      end
    end
    r.on 'new' do
      r.get do
        @parameters = {}
        view('train_new')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(TrainNewFormSchema.call(r.params))
        if @parameters.success?
          @trains = opts[:trains].add_trains(@parameters)
          r.redirect(trains_path)
        else
          view('train_new')
        end
      end
    end
    r.on 'filter' do
      r.get do
        @parameters = DryResultFormeWrapper.new(FullFilterFormSchema.call(r.params))
        @trains = if @parameters.success?
                    opts[:trains].full_filter(@parameters)
                  else
                    opts[:trains].all_trains
                  end
        view('train_full_filter')
      end
    end
  end
end
