#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'date'

#Сделать хеш, содеращий месяцы и количество дней в месяце. В цикле выводить те месяцы, у которых количество дней ровно 30
def days_in_month(month, year = Time.now.year)
  if month.nil? || month==0
    return nil
  end
  Date.civil(year, month, -1).day
end

months = Hash.new
Date::MONTHNAMES.each_with_index do |s,i|
  if i>0
    months[s] = days_in_month(i)
  end
  puts s if months[s]==30
end
