# -*- encoding: utf-8 -*-

require_relative 'train'

class CargoTrain < Train
  def initialize(number)
    super(Train::CARGO, number)
  end
end