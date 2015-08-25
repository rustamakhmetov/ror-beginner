#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

#Заполнить массив числами от 10 до 100 с шагом 5
a = []
(10..100).step(5) {|n| a << n }
p a