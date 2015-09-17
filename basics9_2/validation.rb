# -*- encoding: utf-8 -*-

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, *args)
      validates_name = '@validates'
      instance_variable_set(validates_name, {}) unless instance_variable_defined?(validates_name)
      instance_variable_get(validates_name)[name] = *args
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get('@validates').each do |name, args|
        send("validate_#{args[0]}", name, *args[1, args.size])
      end
    end

    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end

    private

    def validate_presence(name)
      value = instance_variable_get("@#{name}")
      fail ArgumentError, 'Argument is empty string' if value.nil? || value.empty?
    end

    def validate_format(name, format)
      value = instance_variable_get("@#{name}")
      fail ArgumentError, 'Invalid format' unless value =~ format
    end

    def validate_type(name, type)
      value = instance_variable_get("@#{name}")
      fail ArgumentError, 'Invalid type' unless value.instance_of? type
    end
  end
end
