module Furs
	module Models
		class Address < Furs::Models::BaseRequest

			attr_accessor :street, :house_number, :house_number_additional, :community, :city, :postal_code

			validates :street, :community, presence: true, length: 1..100
			validates :house_number, presence: true, length: 1..10
			validates :house_number_additional, allow_nil: true, length: 1..10
			validates :city, presence: true, length: 1..40
			validates :postal_code, presence: true, length: { is: 4 }

			def initialize s = nil, hn = nil, hna = nil, town = nil, cty = nil, pc = nil
				@street = s
				@house_number = hn
				@house_number_additional = hna
				@community = town
				@city = cty
				@postal_code = pc
			end
		end
	end
end