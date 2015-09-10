# -*- encoding: utf-8 -*-

#Маршрут:
# Имеет начальную и конечную станцию, а также список промежуточных станций
# Может добавлять станцию в список
# Может удалять станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

require_relative 'railway_station'

class Route
  attr_reader :stations

  def initialize(stations)
    @stations = stations
  end
  def +(station)
    raise UserException, "Invalid station type" unless station.instance_of?(RailwayStation)
    @stations << station unless @stations.include?(station)
    self
  end
  def -(station)
    @stations.delete(station)
    self
  end
  def first
    @stations.first
  end
  def last
    @stations.last
  end
  def next(station)
    if last!=station
      @stations[@stations.index(station)+1]
    else
      nil
    end
  end
  def prev(station)
    if first!=station
      @stations[@stations.index(station)-1]
    else
      nil
    end
  end
  def to_s
    s = []
    @stations.each_with_index { |station, i| s << "#{i+1}. #{station}"}
    s.join("\n")
  end

end

if __FILE__==$0
  r1 = Route.new([])
  r1 += RailwayStation.new("M34")
  r1 += FalseClass

end