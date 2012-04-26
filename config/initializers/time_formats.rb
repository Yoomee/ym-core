{
  :date => "%d/%m/%Y",
  :month_day_year_or_not => "%B %o%O"
}.each do |k,v|
  Time::DATE_FORMATS[k] = v
  Date::DATE_FORMATS[k] = v
end