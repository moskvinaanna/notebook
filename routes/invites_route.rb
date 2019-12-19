# frozen_string_literal: true

require_relative '../helpers/invitations'
require 'date'
# invites route
class App
  hash_branch('invites') do |r|
    set_layout_options template: '../views/layout'
    set_view_subdir 'invitations'

    r.is do
      r.get do
        @statuses = opts[:statuses]
        @status = r.params['select']
        @event = r.params['event']
        @time = r.params['event_date']
        @place = r.params['address']
        @file_name = r.params['file_name'] || ''
        @invited_people = if !opts[:statuses][name: @status].nil?
                            opts[:statuses][name: @status].notes
                          else
                            []
                          end
        @result = validate_contract(InvitationsContract, r.params)
        @errors = {}
        if @result.failure?
          @errors = @result.errors.to_h
          @invited_people = []
        else
          Invitations.create_list(@invited_people, @file_name)
          Invitations.create_invitations(@invited_people, @event, @time, @place)
        end
        view :invites
      end
    end
  end
end
