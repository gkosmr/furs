module Furs
	module Models
		class VAT < Furs::Models::BaseRequest

			attr_accessor :tax_rate, :taxable_amount, :tax_amount

			validates :tax_rate, presence: true, format: Furs::Constant::DECIMAL_REGEX, numericality: { less_than: 1000 }
			validates :taxable_amount, :tax_amount, presence: true, format: Furs::Constant::DECIMAL_REGEX, numericality: { less_than: 1000000000000 }

			def initialize
			end

			def decimal_fields
				%w(tax_rate taxable_amount tax_amount)
			end

		end
	end
end