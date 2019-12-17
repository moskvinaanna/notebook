require 'sqlite3'
require 'sequel'
require 'date'
DB = Sequel.connect("sqlite:///#{File.expand_path('./db/notes.db', __dir__)}")
require_relative 'models/note'
require_relative 'models/status'
require 'pry'
binding.pry
Note[1].statuses