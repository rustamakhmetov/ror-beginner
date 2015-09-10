# -*- encoding: utf-8 -*-
require_relative 'wagon'

class CargoWagon < Wagon
  def initialize
    super(Wagon::CARGO)
  end
end