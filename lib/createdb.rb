# frozen_string_literal: true

require 'sqlite3'
require 'sequel'
# Creates database
module CreateDb
  DB = Sequel.connect("sqlite:///#{File.expand_path('../db/notes.db', __dir__)}")
  def create_db
    return if DB.table_exists?

    DB.create_table(:notes) do
      primary_key :id
      String :name, null: false, size: 100
      String :surname, null: true, size: 100
      String :patronymic_name, null: true, size: 100
      String :cell_phone_num, null: true, size: 20
      String :home_phone_num, null: true, size: 15
      String :address, null: true, size: 200
      Date :birthday_date, null: true
      String :gender, null: false
      String :status, null: false, size: 100
    end
  end
end
DB = Sequel.connect("sqlite:///#{File.expand_path('../db/notes.db', __dir__)}")
notes = DB[:notes]
notes.insert(name: "мама", gender: "женщина", status: "семья")
notes.insert(name: "папа", gender: "мужчина", status: "семья")
notes.insert(name: "кот", gender: "мужчина", status: "семья")
