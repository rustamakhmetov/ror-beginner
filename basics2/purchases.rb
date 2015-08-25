#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

# Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом).
# Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара.
# На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш,
# содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

products = Hash.new
while true
  puts "Введите наименование товара (стоп или stop - завершить ввод):"
  name = gets.chomp
  break if name=="стоп" || name=="stop"
  puts "Введите цену товара:"
  price = gets.to_f
  puts "Введите кол-во товара:"
  amount = gets.to_f
  products[name] = {price: price, amount: amount, summa: price*amount}
end

summa_total = 0
products.each do |name, data|
  summa_total+=data[:summa]
  puts "Наименование: #{name}, цена: #{data[:price]}, кол-во: #{data[:amount]}, сумма: #{data[:summa]}"
end
puts "В корзине нет покупок" if products.empty?
puts "Итоговая сумма: #{summa_total}"

