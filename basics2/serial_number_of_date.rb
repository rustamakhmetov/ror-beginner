#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным

puts "Введите день:"
day = gets.to_i
puts "Введите месяц:"
month = gets.to_i
puts "Введите год:"
year = gets.to_i

months = [nil,31,28,31,30,31,30,31,31,30,31,30,31]
months[2] = 29 if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
if day>months[month]
  puts "Неверная дата. В этом месяце #{months[month]} дней"
  exit
end
day_number = (month>1 ? months.slice(1, month-1).inject(:+) : 0) + day
puts "Порядковый номер даты: #{day_number}"