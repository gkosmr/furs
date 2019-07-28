module Furs
	module Models
		class ReferenceInvoice < Furs::Models::BaseRequest

			attr_accessor :reference_invoice_identifier, :reference_invoice_issue_date_time

			validates :reference_invoice_issue_date_time, allow_blank: true, format: Furs::Constant::DATE_TIME_REGEX

			def initialize
				@reference_invoice_identifier = Furs::Models::InvoiceIdentifier.new
			end
		end
	end
end