class App
  hash_branch('closest_dates') do |r|
    set_layout_options template: '../views/layout'
    set_view_subdir 'notes'

    r.is do
      r.get do
        view :date_pick
      end
      r.post do
        symboled_params = r.params.map { |key, value| [key.to_sym, value]}.to_h
        @date = symboled_params[:date]
        @notes = opts[:notes].closest_dates(@date)
        view :notes
      end

      r.on 'results' do
        r.get do
          @notes = opts[:notes].closest_dates(@date)
          view :notes
        end
      end
    end
  end
end
