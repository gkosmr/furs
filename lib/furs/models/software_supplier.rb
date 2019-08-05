module Furs
	module Models
		class SoftwareSupplier < Furs::Models::BaseRequest

			attr_accessor :tax_number, :name_foreign

			validates :tax_number, allow_blank: true, length: { is: 8 }
			validates :name_foreign, allow_blank: true, length: 1..1000
			validate do
				errors.add(:base, 'Only one of the fields can be blank') if (tax_number.blank? && name_foreign.blank?) || (!tax_number.blank? && !name_foreign.blank?)
			end

			def initialize tn = nil, nm = nil
				@tax_number = tn
				@name_foreign = nm
			end

			def int_fields
				%w(tax_number)
			end
		end
	end
end