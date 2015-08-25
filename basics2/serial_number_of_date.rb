#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'date'

# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным

puts "Enter day:"
day = gets.to_i
puts "Enter month:"
month = gets.to_i
puts "Enter year:"
year = gets.to_i

puts "Number of the day: #{Date.new(y=year,m=month,d=day).yday}"