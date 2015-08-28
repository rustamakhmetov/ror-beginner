# -*- encoding: utf-8 -*-

require_relative 'train'

class PassangerTrain < Train
  def initialize(number, count_wagons)
    super(Train::PASSANGER, count_wagons, number)
  end
end