# -*- encoding: utf-8 -*-

# Станция:
#   Имеет название, которое указывается при ее создании
#   Может принимать поезда
#   Может показывать список всех поездов на станции, находящиеся в текущий момент
#   Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
#   Может отправлять поезда (при этом, поезд удаляется из списка поездов, находящихся на станции).

require_relative 'train'
require_relative 'instance_counter'
require_relative 'user_exception'

class RailwayStation
  attr_reader :name

  include InstanceCounter

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << name
    validate!
    register_instance
  end

  def self.all()
    puts @@stations.join("\n")
  end

  def valid?
    validate!
  rescue
    false
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

  def update!(&block)
    if block_given?
      @trains.each {|train| yield(train)}
    end
  end

  def to_s
    @name
  end

  protected

  def validate!
    raise UserException, "Railway station name can't be nil" if name.nil?
    raise UserException, "Railway station name should be at least 3 symbols" if name.length < 3
    true
  end

end

if __FILE__== $0
  r1 = RailwayStation.new("M12")
  r2 = RailwayStation.new("M24")
  r3 = RailwayStation.new("M34")
  RailwayStation.all
  r1 << Train.new(Train::PASSANGER, "234-56")
  r1 << Train.new(Train::CARGO, "2r4-56")
  r1.update! {|x| puts x}
end