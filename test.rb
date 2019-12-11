require 'sqlite3'
require 'sequel'
DB = Sequel.connect("sqlite:///#{File.expand_path('./db/notes.db', __dir__)}")
require_relative 'models/note'
require 'pry'
binding.pry
pp(Note[1])