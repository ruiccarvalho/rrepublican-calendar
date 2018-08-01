require 'date'

class FrenchRepublicanDate
  attr_accessor :year, :month, :day

  FRENCH_REPUBLICAN_EPOCH = Date.jd(2375840)

  def initialize(year = 1, month = 1, day = 1)
    @day = day
    @month = month
    @year = year
  end

  def self.from_days(days)
    year = 1
    loop do
      break unless days >= (year_days = sextil?(year) ? 366 : 365)
      days -= year_days
      year += 1
    end
    month = 1 + (days / 30).to_i
    day = 1 + (days % 30).to_i
    new(year, month, day)
  end

  def self.sextil?(year)
    year % 4 == 0
  end

  def to_days
    days = 0
    (1..(year - 1)).each do |y|
      days += FrenchRepublicanDate.sextil?(y) ? 366 : 365
    end
    days += (month - 1) * 30
    days += day - 1
  end

  def sextil?
    FrenchRepublicanDate.sextil?(year)
  end

  def to_gregorian
    FRENCH_REPUBLICAN_EPOCH + to_days
  end
end

Date.class_eval do
  def to_republican
    FrenchRepublicanDate.from_days(
      self - FrenchRepublicanDate::FRENCH_REPUBLICAN_EPOCH
    )
  end
end
