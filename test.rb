require 'sqlite3'
require 'sequel'
require 'date'
DB = Sequel.connect("sqlite:///#{File.expand_path('./db/notes.db', __dir__)}")
require_relative 'models/note'
require_relative 'models/status'
require 'pry'
sel_date = Date.new(2019, 12, 13).strftime("%F")
binding.pry

Note[1].statuses