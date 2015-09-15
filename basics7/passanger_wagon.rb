# -*- encoding: utf-8 -*-

require_relative 'wagon'

class PassangerWagon < Wagon
  def initialize
    super(Wagon::PASSANGER)
  end
end
