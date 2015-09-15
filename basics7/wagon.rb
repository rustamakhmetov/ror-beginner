# -*- encoding: utf-8 -*-

require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'user_exception'

class Wagon
  CARGO = :cargo
  PASSANGER = :passanger

  include Manufacturer
  include InstanceCounter

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
    register_instance
  end

  def valid?
    validate!
  rescue
    false
  end

  def to_s
    "#{@type.to_s.capitalize}Wagon"
  end

  protected

  def validate!
    fail UserException, "Wagon type can't be nil" if type.nil?
    fail UserException, 'Invalid wagon type' unless [CARGO, PASSANGER].include?(type)
    true
  end
end
