module Furs
	module Models
		class Invoice < Furs::Models::BaseInvoice

			attr_accessor :issue_date_time, :numbering_structure, :invoice_identifier, :operator_tax_number, :foreign_operator, :protected_i_d, :subsequent_submit

			validates :issue_date_time, presence: true, format: Furs::Constant::DATE_TIME_REGEX
			validates :numbering_structure, presence: true, inclusion: { in: %w(B C) }
			validates :invoice_identifier, presence: true
			validates :operator_tax_number, allow_blank: true, length: { is: 8 }
			validates :foreign_operator, :subsequent_submit, allow_blank: true, inclusion: { in: [0,1] }
			validates :protected_i_d, presence: true, format: Furs::Constant::HEXADECIMAL_REGEX, length: { is: 32 }

			def initialize
				super
				@invoice_identifier = Furs::Models::InvoiceIdentifier.new
			end

			def int_fields
				%w(operator_tax_number)
			end
		end
	end
end