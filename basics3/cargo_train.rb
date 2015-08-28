# -*- encoding: utf-8 -*-

require_relative 'train'

class CargoTrain < Train
  def initialize(number, count_wagons)
    super(Train::CARGO, count_wagons, number)
  end
end