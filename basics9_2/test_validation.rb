# -*- encoding: utf-8 -*-

require_relative 'validation'
require_relative 'railway_station'

class TestValidation
  include Validation
  attr_accessor :name, :number, :station

  validate :name, :presence
  validate :number, :format, /A-Z{0,3}/
  validate :station, :type, RailwayStation
end

if __FILE__ == $PROGRAM_NAME
  t = TestValidation.new
  t.name = 'test'
  t.number = 'A-Z'
  t.station = RailwayStation.new('RT1')
  puts t.valid?

  t.name = ''
  t.number = 'A-Z'
  t.station = RailwayStation.new('RT1')
  puts t.valid?

  t.name = 'test'
  t.number = 'A'
  t.station = RailwayStation.new('RT1')
  puts t.valid?

  t.name = 'test'
  t.number = 'A-Z'
  t.station = Class.new
  puts t.valid?
end
