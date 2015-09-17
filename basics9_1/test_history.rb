# -*- encoding: utf-8 -*-

require_relative 'history'

class TestHistory
  include History
  attr_accessor_with_history :a1, :a2
  strong_attr_acessor :a3, String
end

if __FILE__ == $PROGRAM_NAME
  t = TestHistory.new
  puts t.a1.inspect
  puts t.a1_history.inspect
  4.times { |i| t.a1 = i }
  puts t.a1
  puts t.a1_history.inspect
  (6..10).each { |i| t.a2 = i }
  puts t.a2
  puts t.a2_history.inspect
  t2 = TestHistory.new
  puts t2.a1

  t.a3 = 'dddd'
  puts t.a3
  t.a3 = 1
end
