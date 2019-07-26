module Furs
  module Configurable

    def config
      @config ||= ::Furs::Configuration.new
    end

    def configure
      yield config if block_given?
    end

  end
end