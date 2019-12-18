class App
  hash_branch('closest_dates') do |r|
    set_layout_options template: '../views/layout'
    set_view_subdir 'date_search'

    r.is do
      r.get do
        @date = r.params['date']
        @notes = @date != nil ? opts[:notes].closest_dates(Date.parse @date) : []
        @statuses = opts[:statuses]
        view :date_pick
      end
    end
  end
end
