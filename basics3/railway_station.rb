# -*- encoding: utf-8 -*-

# Станция:
#   Имеет название, которое указывается при ее создании
#   Может принимать поезда
#   Может показывать список всех поездов на станции, находящиеся в текущий момент
#   Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
#   Может отправлять поезда (при этом, поезд удаляется из списка поездов, находящихся на станции).

require_relative 'train'

class RailwayStation
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def <<(train)
    @trains << train unless @trains.include?(train)
  end

  def >>(train)
    @trains.delete(train)
  end

  def get_formatted_trains_by_type(sep="\n")
    trains_by_type = {Train::CARGO => 0, Train::PASSANGER => 0}
    @trains.each {|train| trains_by_type[train.type]+=1}
    s = []
    trains_by_type.each do |k,v|
      s << "#{k.capitalize} - #{v}"
    end
    s.join(sep)
  end

  def get_formatted_trains()
    if @trains.any?
      s = ""
      @trains.each_with_index do |train, i|
        s+= "#{i+1}. Train '#{train}', speed: #{train.speed}, wagons: #{train.wagons.size}\n"
      end
    else
      s = "On station '#{self}' not trains"
    end
    s
  end
  def trains?
    @trains.any?
  end
  def send_train(train)
    if @trains.include?(train)
      @trains.delete train
      true
    else
      false
    end
  end

  def to_s
    @name
  end

end

