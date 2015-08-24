#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

# Прямоугольный треугольник.
# Программа запрашивает у пользователя 3 стороны треугольника и определяет, является ли треугольник прямоугольным,
# используя теорему Пифагора и выводит результат на экран.
# Также, если треугольник является при этом равнобедренным (т.е. у него равны любые 2 стороны),
# то дополнитьельно выводится информация о том, что треугольник еще и равнобедренный.
# Подсказка: чтобы воспользоваться теоремой Пифагора, нужно сначала найти самую длинную сторону (гипотенуза)
# и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон.
# Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.
puts "Введите 1 сторону треугольника:"
side1 = gets.to_f
puts "Введите 2 сторону треугольника:"
side2 = gets.to_f
puts "Введите 3 сторону треугольника:"
side3 = gets.to_f
if side1 == side2 && side1 == side3
  puts "Треугольник равнобедренный и равносторонний"
else
  sides = [side1, side2, side3]
  hypotenuse = sides.max
  sides.delete_at(sides.index(hypotenuse) || sides.length) # катеты
  pifagor_hypotenuse = Math.sqrt(sides[0]**2 + sides[1]**2)
  msg = []
  if hypotenuse == pifagor_hypotenuse
    msg << 'прямоугольный'
  end
  if side1==side2 || side1==side3 || side2==side3
    msg << 'равнобедренный'
  end
  puts "Треугольник #{msg.join('и')}"
end



