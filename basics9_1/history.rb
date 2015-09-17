# -*- encoding: utf-8 -*-

module History
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*args)
      attrs_name = '@attrs'
      args.each do |name|
        define_method("#{name}=") do |argument|
          instance_variable_set(attrs_name, {}) unless instance_variable_defined?(attrs_name)
          value = instance_variable_get(attrs_name)
          value[name] ||= []
          value[name] << argument
        end
        define_method(name) do
          history = send("#{name}_history")
          return history.last unless history.nil?
        end
        define_method("#{name}_history") do
          value = instance_variable_get(attrs_name)
          return nil if value.nil? || value[name].nil?
          value[name]
        end
      end
    end

    def strong_attr_acessor(attr_name, attr_class)
      define_method("#{attr_name}=") do |argument|
        fail ArgumentError, 'Invalid argument type' unless argument.instance_of? attr_class
        instance_variable_set "@#{attr_name}", argument
      end
      define_method("#{attr_name}") do
        instance_variable_get("@#{attr_name}")
      end
    end
  end
end
