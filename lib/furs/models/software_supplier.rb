module Furs
	module Models
		class SoftwareSupplier < Furs::Models::BaseRequest

			attr_accessor :tax_number, :name_foreign

			validates :tax_number, allow_nil: true, length: { is: 8 }
			validates :name_foreign, allow_nil: true, length: 1..1000
			validate do
				errors.add(:base, 'Only one of the fields can be blank') if (tax_number.nil? && name_foreign.nil?) || (!tax_number.nil? && !name_foreign.nil?)
			end

			def initialize tn = nil, nm = nil
				@tax_number = tn
				@name_foreign = nm
			end
		end
	end
end