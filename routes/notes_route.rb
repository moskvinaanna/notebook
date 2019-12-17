class App
  hash_branch('notes') do |r|
    set_layout_options template: '../views/layout'
    set_view_subdir 'notes'

    r.is do
      r.get do
        @notes = opts[:notes].all
        view :notes
      end
    end

    r.on Integer do |note_id|
      r.is do
        r.get do
          @note = opts[:notes][note_id]
          @status = @note.status
          view :note
        end
      end

      r.on 'edit' do
        r.get do
          @note = opts[:notes][note_id]
          view :edit_form

        end
        r.post do
          status_id = @note[:status_id]
          symboled_params = r.params.map { |key, value| [key.to_sym, value]}.to_h
          opts[:notes][note_id].update(cell_phone_num: symboled_params[:cell_phone_num], home_phone_num: symboled_params[:home_phone_num], address: symboled_params[:address])
          opts[:statuses][status_id].destroy if opts[:statuses][status_id]
          r.redirect '/notes'
        end
      end
    end

    r.on 'delete' do
      r.get do
        @notes = opts[:notes].all
        view :note_delete
      end

      r.post do
        symboled_params = r.params.map { |key, value| [key.to_sym, value]}.to_h

        symboled_params.keys.each do |key|
          status_id = Note[key.to_s.to_i][:status_id]
          Note[key.to_s.to_i].destroy
          opts[:statuses][status_id].destroy if opts[:statuses][status_id].notes.empty?
        end
        r.redirect '/notes'
      end
    end

    r.on 'new' do
      r.get do
        @result = SuccessfullResult.new
        @statuses = opts[:statuses].all
        view :note_form
      end

      r.post do
        @result = validate_contract(NotesContract, r.params)
        if @result.failure?
          view :note_form
        else
          symboled_params = r.params.map { |key, value| [key.to_sym, value]}.to_h
          person = symboled_params
          opts[:statuses]
              .find_or_create(name: person[:status])
              .add_note(name: person[:name], surname: person[:surname], patronymic_name: person[:patronymic_name],
                        cell_phone_num: person[:cell_phone_num], home_phone_num: person[:home_phone_num], address: person[:address],
                        birthday_date: person[:birthday_date], gender: person[:gender])

          r.redirect '/notes'
        end
      end
    end
  end
end
