#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

load 'train.rb'
load 'railway_station.rb'
load 'route.rb'

ekb_train = Train.new(:passenger, 7) #  Train::PASSENGER
spb_train = Train.new(:cargo, 20)

ekb_st = RailwayStation.new("Ekb")
mos_st = RailwayStation.new("Moscow")
spb_st = RailwayStation.new("St. Petersburg")
tomsk_st = RailwayStation.new("Tomsk")
volgograd_st = RailwayStation.new("Volgograd")

volgograd_st << spb_train

puts "="*10, "Маршрут", "-"*10
puts "Имеет начальную и конечную станцию, а также список промежуточных станций"
route = Route.new([ekb_st, mos_st, volgograd_st, spb_st])
puts route, "\n"
puts "добавлять станцию '#{tomsk_st}' в список"
route += tomsk_st
puts route, "\n"
puts "удалять станцию '#{mos_st}' из списка"
route -= mos_st
puts route, "\n"
puts "начальную станцию '#{route.first}'"
puts "конечную станцию '#{route.last}'"

puts "", "="*10, "Train", "-"*10
puts "Current route:\n#{route}"
puts "----Simulate----"
ekb_train.route = route
puts "Current station: #{ekb_train.station} (last:'#{ekb_train.prev_station}', next:'#{ekb_train.next_station}')"
while ekb_train.go
  puts ">>> GO train '#{ekb_train}'"
  puts " Current station: #{ekb_train.station} (last:'#{ekb_train.prev_station}', next:'#{ekb_train.next_station}')"
  puts "\t#{ekb_train.station.get_formatted_trains}"
  if ekb_train.station == volgograd_st
    puts "\t[service] Train '#{ekb_train}' add wagon '#{ekb_train.add_wagon ? "true" : "false"}', wagons: #{ekb_train.wagons}, speed: #{ekb_train.speed}"
  end
end
puts "#{ekb_train.terminal_station? ? "Terminal" : "Current"} station: #{ekb_train.station} (last:'#{ekb_train.prev_station}', next:'#{ekb_train.next_station}')"
puts "\t[service] Train '#{ekb_train}' add wagon '#{ekb_train.add_wagon ? "true" : "false"}', wagons: #{ekb_train.wagons}, speed: #{ekb_train.speed}"
puts "\t[service] Train '#{ekb_train}' delete wagon '#{ekb_train.del_wagon ? "true" : "false"}', wagons: #{ekb_train.wagons}, speed: #{ekb_train.speed}"

puts "", "="*10, "Show statistics by trains on stations", "-"*10
route.stations.each do |station|
  puts station
  puts "\t#{station.get_formatted_trains_by_type("\n\t")}"
end

