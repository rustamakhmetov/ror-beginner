# -*- encoding: utf-8 -*-

require_relative 'manufacturer'
require_relative 'instance_counter'

class Wagon
  CARGO = :cargo
  PASSANGER = :passanger

  include Manufacturer
  include InstanceCounter

  attr_reader :type

  def initialize(type)
    @type = type
    register_instance
  end
  def to_s
    "#{@type.to_s.capitalize}Wagon"
  end
end