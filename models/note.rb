require 'sequel'
require_relative 'note'
require 'date'

class Note < Sequel::Model(:notes)
    many_to_one :status

  def self.closest_dates(sel_date)
    date = sel_date.yday
    db["SELECT *, 
      case when (strftime('%j', birthday_date) - #{date} > 0)
      THEN
      strftime('%j',birthday_date) - #{date}
      ELSE
      strftime('%j',birthday_date) + 365 - #{date}
      END
      as datediff,  #{date} as date
      FROM notes ORDER BY datediff"].all
    
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