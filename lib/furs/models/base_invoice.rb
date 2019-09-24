module Furs
	module Models
		class BaseInvoice < Furs::Models::BaseRequest

			attr_accessor :customer_v_a_t_number, :invoice_amount, :returns_amount, :payment_amount, :taxes_per_seller, :reference_sales_book, :reference_invoice, :special_notes
			attr_reader :tax_number

			validates :tax_number, presence: true, length: { is: 8 }, numericality: { only_integer: true }
			validates :customer_v_a_t_number, allow_blank: true, length: 1..20
			validates :invoice_amount, :payment_amount, presence: true, format: Furs::Constant::DECIMAL_REGEX, numericality: { less_than: 1000000000000, greater_than: -1000000000000 }
			validates :returns_amount, allow_blank: true, format: Furs::Constant::DECIMAL_REGEX, numericality: { less_than: 1000000000000, greater_than: -1000000000000 }
			validates :taxes_per_seller, presence: true, length: { minimum: 1 }
			validates :special_notes, allow_blank: true, length: 1..1000

			validate do
				# errors.add(:reference_invoice, 'must be blank if Reference sales book is not blank') if !(reference_invoice.nil? || reference_invoice.empty?) && !(reference_sales_book.nil? || reference_sales_book.empty?)
				errors.add(:taxes_per_seller, 'must be an array') unless taxes_per_seller.is_a?(Array)
				errors.add(:reference_invoice, 'must be an array') unless reference_invoice.is_a?(Array)
				errors.add(:reference_sales_book, 'must be an array') unless reference_sales_book.is_a?(Array)
			end

			def initialize
				@tax_number = Furs.config.tax_number
				@taxes_per_seller = []
				@reference_sales_book = []#Furs::Models::ReferenceSalesBook.new
				@reference_invoice = []#Furs::Models::ReferenceInvoice.new
			end

			def int_fields
				super + %w(tax_number)
			end

			def decimal_fields
				super + %w(invoice_amount payment_amount returns_amount)
			end

			def autofilled
				super + %w(tax_number)
			end
		end
	end
end