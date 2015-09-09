# -*- encoding: utf-8 -*-

require_relative 'manufacturer'

class Wagon
  CARGO = :cargo
  PASSANGER = :passanger

  include Manufacturer

  attr_reader :type

  def initialize(type)
    @type = type
  end
  def to_s
    "#{@type.to_s.capitalize}Wagon"
  end
end