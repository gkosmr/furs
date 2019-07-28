module Furs
	module Models
		class BaseInvoice < Furs::Models::BaseRequest

			attr_accessor :customer_v_a_t_number, :invoice_amount, :returns_amount, :payment_amount, :taxes_per_seller, :reference_sales_book, :reference_invoice, :special_notes

			validates :customer_v_a_t_number, allow_blank: true, length: 1..20
			validates :invoice_amount, :payment_amount, presence: true, format: Furs::Constant::DECIMAL_REGEX, numericality: { less_than: 1000000000000 }
			validates :returns_amount, allow_blank: true, format: Furs::Constant::DECIMAL_REGEX, numericality: { less_than: 1000000000000 }
			validates :taxes_per_seller, presence: true
			validates :special_notes, allow_blank: true, length: 1..1000

			validate do
				errors.add(:base, 'Only one of the fields can be blank') if (reference_invoice.empty? && reference_sales_book.empty?) || (!reference_invoice.empty? && !reference_sales_book.empty?)
			end

			def initialize
				@taxes_per_seller = Furs::Models::TaxesPerSeller.new
				@reference_sales_book = Furs::Models::ReferenceSalesBook.new
				@reference_invoice = Furs::Models::ReferenceInvoice.new
			end
		end
	end
end