# -*- encoding: utf-8 -*-

=begin
# Поезд:
# Имеет, тип, который указывается при создании: грузовой, пассажирский и количество вагонов.
# Поезд может делать следующие вещи:
#  набирать скорость
#  показывать текущую скорость
#  тормозить
#  показывать количество вагонов
  прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает
                               или уменьшает количество вагонов).
    Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Принимать маршрут следования
# Перемещаться между станциями, указанными в маршруте.
# Показывать предыдущую станцию, текущую, следующую, на основе маршрута
=end

require_relative 'passanger_wagon'
require_relative 'cargo_wagon'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'user_exception'
require_relative 'validation'

class Train
  CARGO = :cargo
  PASSANGER = :passanger
  NUMBER_FORMAT = /^[a-z\d]{3}-{0,1}[a-z\d]{2}$/i

  include InstanceCounter
  include Manufacturer
  include Validation

  attr_accessor :speed
  attr_reader :wagons, :type, :route, :station

  validate :type, :type, Symbol, 'Invalid train type'
  validate :number, :format, NUMBER_FORMAT, 'Train number has invalid format'

  @@trains = {}

  def initialize(type, number)
    @type = type
    @wagons = []
    @speed = 0
    @number = number
    fail UserException, "Train with number #{number} is exists" if @@trains.include?(number)
    @@trains[number] = self
    register_instance
    validate!
    # (1..count_wagons).each { |i| add_wagon }
  end

  def valid?
    validate!
  rescue
    false
  end

  def self.find(train_id)
    @@trains[train_id] if @@trains.key?(train_id)
  end

  def route=(route)
    @route = route
    @station = route.first
    @station << self
  end

  def station=(station)
    @station >> self if @station
    @station = station
    @station << self
  end

  def prev_station
    @route.prev(station)
  end

  def next_station
    @route.next(station)
  end

  def go
    if !next_station.nil?
      @speed = 10 if @speed == 0
      @station >> self # delete train from station
      @station = next_station
      @station << self # add train to station
    else
      stop
    end
    @speed > 0
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    message = 'Type of wagon does not match the type of train'
    fail UserException, message if wagon.type != @type
    @wagons << wagon if @speed == 0
    @wagons.size
  end

  def del_wagon(wagon)
    if @speed == 0
      @wagons.delete_at(@wagons.find_index { |x| x.type == wagon.type } || @wagons.size)
    end
    @wagons.size
  end

  def update!(&_block)
    @wagons.each { |wagon| yield(wagon) } if block_given?
  end

  def terminal_station?
    station == route.last
  end

  def to_s
    "#{@type.to_s.capitalize} N#{@number} (#{@wagons.size} wag.)"
  end

  #protected

  #def validate!
  #  validate!
    #fail UserException, "Train type can't be nil" if @type.nil?
    #fail UserException, 'Invalid train type' unless [CARGO, PASSANGER].include?(@type)
    #fail UserException, "Train number can't be nil" if @number.nil?
    #fail UserException, 'Train number has invalid format' if @number !~ NUMBER_FORMAT
  #  true
  #end
end

if __FILE__ == $PROGRAM_NAME
  begin
    #t0 = Train.new(:CARGO, "a33Z-45")
    t1 = Train.new(Train, 'a3Z-45')
    t1 = Train.new(Train::CARGO, 'a3Z-45')
    t1.manufacturer = 'R1'
    t1.add_wagon(CargoWagon.new)
    t1.add_wagon(CargoWagon.new)
    t1.update! { |x| puts x }
    puts t1.manufacturer
    t2 = Train.new(Train::CARGO, 'a3Z-45')
    puts Train.find(1) # output: Cargo N1 (0 wag.)
    puts Train.find(0) # output; nil
    t3 = Train.new(Train::CARGO, 'd45ku')
    puts "Train instances: #{Train.instances}"
    puts t2, t3
  rescue UserException => e
    puts e.message
  end
end
