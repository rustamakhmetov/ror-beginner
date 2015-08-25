#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
vowels = Hash.new
alphabet = ('а'..'я').to_a
alphabet.insert(alphabet.index('ж'), 'ё')
for a in 'а,я,о,ё,у,ю,э,е,ы,и'.split(",").sort
  vowels[a] = alphabet.index(a)+1
end
#p alphabet
p vowels