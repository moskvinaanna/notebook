# frozen_string_literal: true

# closest dates route
class App
  hash_branch('closest_dates') do |r|
    set_layout_options template: '../views/layout'
    set_view_subdir 'date_search'

    r.is do
      r.get do
        @date = r.params['date']
        @errors = {}
        @result = validate_contract(DateContract, r.params)
        if @result.failure?
          @errors = @result.errors.to_h
          @notes = []
        else
          @notes = !@date.nil? && @date != '' ? opts[:notes].closest_dates(Date.parse(@date)) : []
        end
        @statuses = opts[:statuses]
        view :date_pick
      end
    end
  end
end
