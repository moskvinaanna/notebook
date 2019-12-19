# frozen_string_literal: true

# notes route
class App
  hash_branch('notes') do |r|
    set_layout_options template: '../views/layout'
    set_view_subdir 'notes'

    r.is do
      r.get do
        @search = r.params['search']
        @selection = r.params['select']
        @page_number = r.params['page_number']&.to_i || 0
        notes = opts[:notes].search_by(@search, @selection) || opts[:notes]
        @count = notes.count
        @pages_count = (@count.to_f / 5).ceil - 1
        @notes = notes.limit(5, @page_number * 5).all
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
          @statuses = opts[:statuses]
          @errors = {}
          view :edit_form
        end

        r.post do
          @result = validate_contract(EditContract, r.params)
          if @result.failure?
            @note = opts[:notes][note_id]
            @statuses = opts[:statuses]
            @errors = @result.errors.to_h
            view :edit_form
          else
            status_id = opts[:notes][note_id][:status_id]
            symboled_params = r.params.map { |key, value| [key.to_sym, value] }.to_h
            new_status_id = opts[:statuses]
                            .find_or_create(name: symboled_params[:status])[:id]
            opts[:notes].update_note(symboled_params, note_id, new_status_id)
            opts[:statuses][status_id].destroy if opts[:statuses][status_id].notes.empty?
            r.redirect '/notes'
          end
        end
      end
    end

    r.on 'delete' do
      r.get do
        @search = r.params['search']
        @selection = r.params['select']
        @notes = opts[:notes].search_by(@search, @selection) || opts[:notes]
        view :note_delete
      end

      r.post do
        symboled_params = r.params.map { |key, value| [key.to_sym, value] }.to_h
        symboled_params.keys.each do |key|
          next if Note.find(id: key.to_s.to_i).nil?

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
        @errors = {}
        view :note_form
      end

      r.post do
        @result = validate_contract(NotesContract, r.params)
        if @result.failure?
          @statuses = opts[:statuses].all
          @errors = @result.errors.to_h
          view :note_form
        else
          symboled_params = r.params.map { |key, value| [key.to_sym, value] }.to_h
          opts[:statuses].add_new_note(symboled_params)
          r.redirect '/notes'
        end
      end
    end
  end
end
