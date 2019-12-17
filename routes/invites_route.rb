require_relative '../helpers/invitations'
require 'date'
class App
  hash_branch('invites') do |r|
    set_layout_options template: '../views/layout'
    set_view_subdir 'invitations'

    r.is do
      r.get do
        @statuses = opts[:statuses]
        @status = r.params['status']
        @event = r.params['event']
        @time = r.params['event_date']
        @place = r.params['address']
        @invited_people = if opts[:statuses][name: @status] != nil
                            opts[:statuses][name: @status].notes
                          else
                            []
                          end
        Invitations.create_invitations(@invited_people, @event, Date.today, "дом")
        view :invites
      end
    end
  end
end
