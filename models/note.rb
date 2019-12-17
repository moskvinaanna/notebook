require 'sequel'
require_relative 'note'

class Note < Sequel::Model(:notes)
    many_to_one :status

  def self.closest_dates(sel_date)
    where{birthday_date < sel_date}.limit(10).all
  end
end