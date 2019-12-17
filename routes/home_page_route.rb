class App
  hash_branch('home_page') do |r|
    set_layout_options template: '../views/layout'
    r.is do
      r.get do
        view :home_page
      end
    end
  end
end
