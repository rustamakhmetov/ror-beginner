#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

# Заполнить массив числами фибоначи до 100
def fib(n)
  (@d ||= [1,1])[n] ||= (
  fib(n-1) + fib(n-2)
  )
end

fib(100)
puts @d
