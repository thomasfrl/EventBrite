module ApplicationHelper

  def administrator?(event)
    event.administrator == current_user
  end

  def participant?(event)
    event.users.include?(current_user)
  end

  def month(time)
    case time
      when 1  then "Janvier"
      when 2  then "Février"
      when 3  then "Mars"
      when 4  then "Avril"
      when 5  then "Mai"
      when 6  then "Juin"
      when 7  then "Juillet"
      when 8  then "Janvier"
      when 9  then "Janvier"
      when 10  then "Janvier"
      when 11  then "Janvier"
      when 12  then "Janvier"
    end
  end

  def day(date)
    case date.wday
      when 1  then "Lundi"
      when 2  then "Mardi"
      when 3  then "Mercredi"
      when 4  then "Jeudi"
      when 5  then "Vendredi"
      when 6  then "Samedi"
      when 7  then "Dimanche"
    end 
  end
end
