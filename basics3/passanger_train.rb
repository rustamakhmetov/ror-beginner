# -*- encoding: utf-8 -*-

require_relative 'train'

class PassangerTrain < Train
  def initialize(number)
    super(Train::PASSANGER, number)
  end
end