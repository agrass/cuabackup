class DayRegime < ActiveRecord::Base
   attr_accessible :date, :regime_day
   def self.getCurrentDay()
    a = DayRegime.last
    n = (Date.today - a.date).to_i
    a.date = Date.today
    a.regime_day = (n -1 +a.regime_day)%8 + 1
    a.save
    return a.regime_day 
   end

   def self.setCurrentDay(var)
    var = (var -1)%8 + 1
    a = DayRegime.last    
    a.date = Date.today
    a.regime_day = var
    a.save
   end
end
