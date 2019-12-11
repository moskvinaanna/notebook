require 'roda'
require 'sequel'
require 'sqlite3'
require_relative 'lib/notes'

class App < Roda
  plugin :render
  plugin :assets, css: 'layout.css'
  plugin :public
  DB = Sequel.connect("sqlite:///#{File.expand_path('./db/notes.db', __dir__)}")
  require_relative 'models/note'
  
  opts[:notes] = Note

  route do |r|
    r.assets
    r.root do
      r.redirect '/home_page'
    end
    r.on 'home_page' do
      r.is do
        r.get do
          view :home_page
        end
        
      end
    end

    r.on 'notes' do
      r.is do
        r.get do
          @notes = opts[:notes].all
          view :notes
        end
        
      end

      r.on Integer do |note_id|
        r.get do
          @note = opts[:notes][note_id]
          view :note
        end
        r.delete do
          # opts[:notes][note_id]
          # view :notes
        end
      end

      r.on 'new' do
        r.get do
          view :note_form
        end
      
        r.post do
          # cat_contract = CatContract.new
          # symboled_params = r.params.map { |key, value| [key.to_sym, value]}.to_h
          # result = cat_contract.call(**symboled_params)
          # if result.failure?
          # else
          # end
          symboled_params = r.params.map { |key, value| [key.to_sym, value]}.to_h
          # opts[:notes].append(Person.new(**symboled_params))

          person = symboled_params
          opts[:notes].create(name: person[:name], surname: person[:surname], patronymic_name: person[:patronymic_name],
            cell_phone_num: person[:cell_phone_num], home_phone_num: person[:home_phone_num], address: person[:address], 
            birthday_date: person[:birthday_date], gender: person[:gender], status: person[:status])
          r.redirect '/notes'
        end
      end
    end
  end
end

