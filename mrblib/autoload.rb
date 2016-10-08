class Autoloader
  class << self
    @@autoload_registry = {}

    def register(const, path)
      @@autoload_registry[const] = path
      nil
    end

    def autoload_constant(const)
      if(@@autoload_registry[const.to_sym])
        require @@autoload_registry[const.to_sym]
        true
      end
    end
  end

  module Injector
    def autoload(const, path)
      Autoloader.register(const, path)
      nil
    end

    def const_missing_with_autoload(const)
      if(Autoloader.autoload_constant(const))
        if(self.const_defined?(const))
          self.const_get(const)
        else
          const_missing_without_autoload(const)
        end
      else
        const_missing_without_autoload(const)
      end
    end

    def self.included(const)
      const.class_eval do
        alias_method :const_missing_without_autoload, :const_missing
        alias_method :const_missing, :const_missing_with_autoload
      end
    end
  end
end

Module.send(:include, Autoloader::Injector)
