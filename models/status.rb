require 'sequel'

class Status < Sequel::Model(:statuses)
  one_to_many :notes
end
