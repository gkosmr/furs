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

			def generate_zoi! p12
				if protected_i_d.blank? && tax_number.present? && issue_date_time.present? && invoice_identifier.present? && invoice_identifier.valid? && invoice_amount.present?
					tmp = Time.parse issue_date_time
					idt = tmp.strftime "%d.%m.%Y %H:%M:%S"	# must be in format: dd.mm.yyyy HH:MM:SS
					payload = "#{tax_number}#{idt}#{invoice_identifier.invoice_number}#{invoice_identifier.business_premise_i_d}#{invoice_identifier.electronic_device_i_d}#{invoice_amount}"
					@protected_i_d = Furs::Encoder.new(payload, nil, p12.key).zoi
				end
			end

			def int_fields
				super + %w(operator_tax_number)
			end
		end
	end
end