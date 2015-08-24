#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
puts "Введите ваше имя:"
name = gets.chomp
puts "Введите ваш рост:"
growth = gets
if growth.to_i - 110 <= 0
  puts "#{name}! Ваш вес уже оптимальный"
else
  puts "#{name}! Сначала подрасти!"
end