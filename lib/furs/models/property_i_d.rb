module Furs
	module Models
		class PropertyID < Furs::Models::BaseRequest

			attr_accessor :cadastral_number, :building_number, :building_section_number

			validates :cadastral_number, presence: true, format: /\A\d{1,4}\z/
			validates :building_number, presence: true, format: /\A\d{1,5}\z/
			validates :building_section_number, presence: true, format: /\A\d{1,4}\z/

			def initialize cn = nil, bn = nil, bsn = nil
				@cadastral_number = cn
				@building_number = bn
				@building_section_number = bsn
			end
		end
	end
end