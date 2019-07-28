module Furs
	module Models
		class TaxesPerSeller < Furs::Models::BaseRequest

			attr_accessor :seller_tax_number, :v_a_t, :other_taxes_amount, :exempt_v_a_t_taxable_amount, :reverse_v_a_t_taxable_amount, :non_taxable_amount, :special_tax_rules_amount

			validates :seller_tax_number, allow_blank: true, length: { is: 8 }
			validates :other_taxes_amount, :exempt_v_a_t_taxable_amount, :reverse_v_a_t_taxable_amount, :non_taxable_amount, :special_tax_rules_amount, allow_blank: true, format: Furs::Constant::DECIMAL_REGEX, numericality: { less_than: 1000000000000 }

			def initialize
				@v_a_t = Furs::Models::VAT.new
			end
		end
	end
end