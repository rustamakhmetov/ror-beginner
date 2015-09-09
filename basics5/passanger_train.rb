# -*- encoding: utf-8 -*-

require_relative 'train'

class PassangerTrain < Train
  def initialize(number)
    super(Train::PASSANGER, number)
  end
end

if __FILE__ == $0
  p1 = PassangerTrain.new(2)
  p1.manufacturer = "Riga"
  puts p1.manufacturer
  puts PassangerTrain.instances
end