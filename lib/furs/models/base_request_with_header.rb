module Furs
	module Models
		class BaseRequestWithHeader < Furs::Models::BaseRequest

			attr_reader :header

			validates :header, presence: true

			def initialize
				@header = Furs::Models::Header.new
			end
		end
	end
end