# -*- encoding: utf-8 -*-

class Wagon
  CARGO = :cargo
  PASSANGER = :passanger

  attr_reader :type

  def initialize(type)
    @type = type
  end
  def to_s
    "#{@type.to_s.capitalize}Wagon"
  end
end