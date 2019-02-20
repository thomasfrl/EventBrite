class Time
  def month_letter
    case self.month
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

  def day_week
    case self.wday
      when 1  then "Lundi"
      when 2  then "Mardi"
      when 3  then "Mercredi"
      when 4  then "Jeudi"
      when 5  then "Vendredi"
      when 6  then "Samedi"
      when 7  then "Dimanche"
    end 
  end

  def hour_in_letter
    if self.hour <10
      h = "0#{self.hour}"
    else 
      h = self.hour
    end
    if self.min <10
      m = "0#{self.min}"
    else 
      m = self.min
    end
    return "#{h}h#{m}"
  end

end
