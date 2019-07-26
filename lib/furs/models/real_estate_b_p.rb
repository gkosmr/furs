module Furs
	module Models
		class RealEstateBP < Furs::Models::BaseRequest

			attr_accessor :property_i_d, :address

			validates :property_i_d, :address, presence: true

			def initialize
				@property_i_d = Furs::Models::PropertyID.new
				@address =  Furs::Models::Address.new
			end
		end
	end
end