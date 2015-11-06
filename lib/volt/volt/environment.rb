module Volt
  class Environment
    attr_writer :env
    def initialize
      # Use VOLT_ENV or RACK_ENV to set the environment
      @env = ENV['VOLT_ENV'] || ENV['RACK_ENV']

      # If we're in opal, we can set the env from JS before opal loads
      if RUBY_PLATFORM == 'opal'
        unless @env
          `if (window.start_env) {`
          @env = `window.start_env`
          `}`
        end
      end

      @env ||= 'development'
    end

    def ==(val)
      @env == val
    end

    def production?
      self.==('production')
    end

    def test?
      self.==('test')
    end

    def development?
      self.==('development')
    end

    def inspect
      @env.inspect
    end

    def to_s
      @env
    end
  end
end
