load 'rrepublican-calendar.rb'

republican_today = Date.today.to_republican
gregorian_today = republican_today.to_gregorian

gregorian_today == Date.today
