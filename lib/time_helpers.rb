module TimeHelpers
  def at_evening? = (18..21).include? self.hour
  def at_night? = self.hour > 21 || self.hour < 6
  def at_morning? = (6...12).include? self.hour
  def at_afternoon? = (12...18).include? self.hour
end
