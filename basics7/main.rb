#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require_relative 'train'
require_relative 'railway_station'
require_relative 'route'
require_relative 'passanger_train'
require_relative 'cargo_train'

class Main
  def initialize
    @trains = {}
    @stations = []
    fill_types_str
  end

  def start
    loop do
      begin
        show_menu
        menu_id = gets.to_i
        case menu_id
        when 1
          add_station
        when 2
          add_train
        when 3..4
          modify_train(menu_id)
        when 5
          place_train_on_station
        when 6
          show_stations_with_select
        when 7
          show_trains_on_station
        when 8
          puts 'done'
          break
        else
          puts 'Invalid select'
        end
      rescue UserException => e
        puts e.message
      end
      sleep 1
    end
  end

  private

  def fill_types_str
    trains_types_str = []
    Train.constants.each_with_index do |c, i|
      @trains[c] = []
      trains_types_str << "#{i}. #{c}"
    end
    @trains_types_str = trains_types_str.join("\n")

    wagons_types_str = []
    Wagon.constants.each_with_index do |c, i|
      wagons_types_str << "#{i}. #{c}"
    end
    @wagons_types_str = wagons_types_str.join("\n")
  end

  def show_menu
    system('clear')
    puts "Current station: #{@station}, train: #{@train}"
    puts ''"Select:
   1. Создавать станции
   2. Создавать поезда
   3. Добавлять вагоны к поезду
   4. Отцеплять вагоны от поезда
   5. Помещать поезда на станцию
   6. список станций
   7. список поездов на станции
   8. Exit
"''
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
    Train.constants[gets.to_i]
  end

  def input_wagons_count
    puts 'Input wagons count'
    count = gets.to_i
    puts 'The number of cars must be greater than 0' unless count
    count
  end

  def add_train
    train_type = select_type_train
    if train_type
      # wagons_count = input_wagons_count
      num = @trains[train_type].size + 1
      @train = eval("#{train_type.to_s.downcase.capitalize}Train.new(num)")
      @trains[train_type] << @train
      print "Added train '#{@train}'."
      unless @station.nil?
        puts "Placed train on current station '#{@station}'?\n1 - yes\n2 - no"
        user_input = gets.to_i
        if user_input == 1
          @train.station = @station
          print "Train placed to station '#{@station}'"
        end
      end
      print "\n"
    else
      puts 'Invalid select'
    end
  end

  def show_stations_with_select
    if @stations.any?
      loop do
        system('clear')
        puts 'Select station:'
        puts '0 - back to top menu'
        @stations.each_with_index do |st, i|
          puts "#{i + 1}. #{st}"
        end
        station_id = gets.to_i
        case station_id
        when 0
          break
        when (1..@stations.size)
          @station = @stations[station_id - 1]
          break
        else
          puts 'Invalid select'
          sleep 1
        end
      end
    else
      puts 'List stations is empty'
    end
  end

  def show_trains_on_station
    if @station
      puts @station.get_formatted_trains
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

  def get_train_with_select
    train = nil
    train_type = select_type_train
    if train_type
      if @trains[train_type].any?
        show_trains_by_type(train_type)
        train_id = gets.to_i
        if (1..@trains[train_type].size).include?(train_id)
          train = @trains[train_type][train_id - 1]
        else
          puts 'Invalid select'
        end
      else
        puts "List trains by type '#{train_type}' is empty"
      end
    else
      puts 'Invalid select'
    end
    train
  end

  def select_type_wagon
    puts "Select type wagon:\n#{@wagons_types_str}"
    Wagon.constants[gets.to_i]
  end

  def modify_train(modify_id)
    if @train
      wagon_type = select_type_wagon
      if wagon_type
        wagon = eval("#{wagon_type.downcase.capitalize}Wagon.new")
        if modify_id == 3
          @train.add_wagon(wagon)
        else
          @train.del_wagon(wagon)
        end
      else
        puts 'Invalid select'
      end
    else
      puts 'Please select or add train'
    end
  end

  def place_train_on_station
    show_stations_with_select unless @station
    if @station
      train = get_train_with_select
      if train
        train.station = @station
        puts "Train '#{@train}' placed to station '#{@station}'"
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  main = Main.new
  main.start
end
