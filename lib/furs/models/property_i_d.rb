module Furs
	module Models
		class PropertyID < Furs::Models::BaseRequest

			attr_accessor :cadastral_number, :building_number, :building_section_number

			validates :cadastral_number, :building_section_number, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 10000 }
			validates :building_number, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 100000 }

			def initialize cn = nil, bn = nil, bsn = nil
				@cadastral_number = cn
				@building_number = bn
				@building_section_number = bsn
			end

			def int_fields
				%w(cadastral_number building_number building_section_number)
			end
		end
	end
end