# frozen_string_literal: true

# home_page route
class App
  hash_branch('home_page') do |r|
    set_layout_options template: '../views/layout'
    set_view_subdir 'home_page'
    r.is do
      r.get do
        view :home_page
      end
    end
  end
end
