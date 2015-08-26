#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

# Заполнить массив числами фибоначи до 100
def fib(n)
  (@d ||= [0,1,1])[n] ||= (
  fib(n-1) + fib(n-2)
  )
end

def fib2(n)
  f = [0, 1]
  (2..n).each do |i|
    f << (f[i-1] + f[i-2])
  end
  f
end

number = 100

#fib(number)
#p @d
puts fib2(number)
