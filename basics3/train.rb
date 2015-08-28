# -*- encoding: utf-8 -*-

#Поезд:
# Имеет, тип, который указывается при создании: грузовой, пассажирский и количество вагонов.
# Поезд может делать следующие вещи:
#  набирать скорость
#  показывать текущую скорость
#  тормозить
#  показывать количество вагонов
#  прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
#    Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Принимать маршрут следования
# Перемещаться между станциями, указанными в маршруте.
# Показывать предыдущую станцию, текущую, следующую, на основе маршрута
require_relative 'passanger_wagon'
require_relative 'cargo_wagon'


class Train
  CARGO = :cargo
  PASSANGER = :passanger

  attr_accessor :speed
  attr_reader :wagons, :type, :route, :station

  def initialize(type, count_wagons, number)
    @type = type
    @wagons = []
    @speed = 0
    @number = number
    (1..count_wagons).each { |i| add_wagon }
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
      if @speed == 0
        @speed = 10
      end
      @station >> self # delete train from station
      @station = next_station
      @station << self # add train to station
    else
      stop
    end
    @speed>0
  end

  def stop
    @speed = 0
  end

  def add_wagon(count=1)
    if @speed==0
      count.times { @wagons << eval("#{@type.capitalize}Wagon.new") }
    end
    @wagons.size
  end

  def del_wagon(count=1)
    if @speed==0
      count = @wagons.size if count>@wagons.size
      count.times { @wagons.pop }
    end
    @wagons.size
  end

  def terminal_station?
    station==route.last
  end

  def to_s
    "#{@type.to_s.capitalize} N#{@number} (#{@wagons.size} wag.)"
  end
end

