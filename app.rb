require 'roda'
require 'sequel'
require 'sqlite3'
require_relative 'helpers/contract_helper'
require_relative 'helpers/successfull_result'
require_relative 'lib/notes_contract'

class App < Roda
  plugin :render
  plugin :public
  plugin :hash_routes
  plugin :view_options
  DB = Sequel.connect("sqlite:///#{File.expand_path('./db/notes.db', __dir__)}")
  require_relative 'models/note'
  require_relative 'models/status'

  include ContractHelper
  
  opts[:notes] = Note
  opts[:statuses] = Status
  require_relative 'routes/home_page_route'
  require_relative 'routes/notes_route'
  require_relative 'routes/closest_dates_route'
  require_relative 'routes/invites_route'


  route do |r|
    r.public
    r.hash_branches
    r.root do
      r.redirect '/home_page'
    end
  end
end

