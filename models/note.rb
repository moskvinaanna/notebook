require 'sequel'
require_relative 'note'

class Note < Sequel::Model(:notes)
    many_to_one :status

  def self.closest_dates(sel_date)
    where{birthday_date < sel_date}.limit(10).all
  end

  def self.search_by(search, selection)
      case selection
      when 'Фамилии'
        where(Sequel[:surname].like("#{search}%"))
      when 'Имени'
        where(Sequel[:name].like("#{search}%"))
      when 'Статусу'
        where(status_id: Status.where(Sequel[:name].like("#{search}%")).get(:id))
      end
    end
end