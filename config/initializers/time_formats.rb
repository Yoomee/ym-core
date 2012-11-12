{
  :date => "%d/%m/%Y",
  :date_and_time => "%d/%m/%Y at %H:%M",
  :month_day_year_or_not => "%B %o%O",
  :day_and_date => "%a %e"
}.each do |k,v|
  Time::DATE_FORMATS[k] = v
  Date::DATE_FORMATS[k] = v
end