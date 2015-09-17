#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require_relative 'train'
require_relative 'railway_station'
require_relative 'route'
require_relative 'passanger_train'
require_relative 'cargo_train'
require_relative 'utils'

class Main
  def initialize
    @trains = {}
    @stations = []
    @menu = {
      1 => 'Создавать станции',
      2 => 'Создавать поезда',
      3 => 'Добавлять вагоны к поезду',
      4 => 'Отцеплять вагоны от поезда',
      5 => 'Помещать поезда на станцию',
      6 => 'список станций',
      7 => 'список поездов на станции',
      8 => 'Exit'
    }
    fill_types_str
  end

  def start
    loop do
      manager
    end
  rescue UserException => e
    puts e.message
    sleep 1
    retry
  rescue RuntimeError => e
    puts e.message
  end

  private

  def manager
    menu_id = show_menu
    case menu_id
    when 1 then add_station
    when 2 then add_train_with_select
    when 3..4 then modify_train(menu_id)
    when 5 then place_train_on_station_with_select
    when 6 then show_stations_with_select
    when 7 then show_trains_on_station
    when 8 then fail 'done'
    end
  end

  def fill_types_str
    make_trains_str
    make_wagons_str
  end

  def make_wagons_str
    wagons_types_str = []
    Wagon.constants.each_with_index do |c, i|
      wagons_types_str << "#{i}. #{c}"
    end
    @wagons_types_str = wagons_types_str.join("\n")
  end

  def make_trains_str
    trains_types_str = []
    Train.constants.each_with_index do |c, i|
      @trains[c] = []
      trains_types_str << "#{i}. #{c}"
    end
    @trains_types_str = trains_types_str.join("\n")
  end

  def show_menu
    message = "Current station: #{@station}, train: #{@train}\nВыберите:"
    menu = @menu.clone
    if @train.nil?
      menu.delete(3)
      menu.delete(4)
    end
    Utils.show_menu_with_select(menu, message)
  end

  def add_station
    puts 'Input station name:'
    station_name = gets.chomp.capitalize
    if @stations.find { |x| x.name == station_name }.nil?
      puts "Added station '#{station_name}'"
      @stations << RailwayStation.new(station_name)
      @station = @stations.last
    else
      puts "Station '#{station_name}' is exists"
    end
  end

  def select_type_train
    puts "Select type train:\n#{@trains_types_str}"
    type_train = Train.constants[gets.to_i]
    puts 'Invalid select' unless type_train
    type_train
  end

  def input_wagons_count
    puts 'Input wagons count'
    count = gets.to_i
    puts 'The number of cars must be greater than 0' unless count
    count
  end

  def add_train_with_select
    train_type = select_type_train
    return unless train_type
    add_train(train_type)
    place_train_on_current_station unless @station.nil?
    print "\n"
  end

  def add_train(train_type)
    num = @trains[train_type].size + 1
    @train = PassangerTrain.new(num) if train_type == Train::PASSANGER
    @train = CargoTrain.new(num) if train_type == Train::CARGO
    @trains[train_type] << @train
    print "Added train '#{@train}'."
  end

  def place_train_on_current_station
    menu = {
      1 => 'yes',
      2 => 'no'
    }
    message = "Placed train on current station '#{@station}'?"
    user_input = Utils.show_menu_with_select(menu, message, false)
    place_train_on_station(@station, @train) if user_input == 1
  end

  def place_train_on_station(station, train)
    train.station = station
    print "Train placed to station '#{station}'"
  end

  def show_stations_with_select
    if @stations.any?
      station_id = nil
      until station_id < 1
        show_stations
        station_id = select_station
      end
    else
      puts 'List stations is empty'
    end
  end

  def select_station
    station_id = gets.to_i
    case station_id
    when 0 then true
    when (1..@stations.size) then @station = @stations[station_id - 1]
    else
      station_id = nil
      puts 'Invalid select'
      sleep 1
    end
    station_id
  end

  def show_stations
    system('clear')
    puts 'Select station:'
    puts '0 - back to top menu'
    @stations.each_with_index do |st, i|
      puts "#{i + 1}. #{st}"
    end
  end

  def show_trains_on_station
    if @station
      puts @station.formatted_trains
      puts 'Press [ENTER] for continue'
      gets
    else
      puts 'Please select or add station'
    end
  end

  def show_trains_by_type(type, tab = '')
    @trains[type].each_with_index do |train, i|
      puts "#{tab}#{i + 1}. #{train}"
    end
  end

  def train_with_select
    train = nil
    train_type = select_type_train
    return unless train_type
    if @trains[train_type].any?
      show_trains_by_type(train_type)
      train = select_train(train_type)
    else
      puts "List trains by type '#{train_type}' is empty"
    end
    train
  end

  def select_train(train_type)
    train_id = gets.to_i
    if (1..@trains[train_type].size).include?(train_id)
      train = @trains[train_type][train_id - 1]
    else
      puts 'Invalid select'
    end
    train
  end

  def select_type_wagon
    puts "Select type wagon:\n#{@wagons_types_str}"
    wagon_type = Wagon.constants[gets.to_i]
    puts 'Invalid select' unless wagon_type
  end

  def modify_train(modify_id)
    wagon_type = select_type_wagon
    return unless wagon_type
    wagon = wagon_by_type(wagon_type)
    if modify_id == 3
      @train.add_wagon(wagon)
    else
      @train.del_wagon(wagon)
    end
  end

  def wagon_by_type(wagon_type)
    if wagon_type == Wagon::PASSANGER
      wagon = PassangerWagon.new
    else
      wagon = CargoWagon.new
    end
    wagon
  end

  def place_train_on_station_with_select
    show_stations_with_select unless @station
    return unless @station
    train = train_with_select
    return unless train
    place_train_on_station(@station, train)
  end
end

if __FILE__ == $PROGRAM_NAME
  main = Main.new
  main.start
end
