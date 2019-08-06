module Furs
	module Models
		class InvoiceRequest < Furs::Models::BaseRequestWithHeader

			attr_accessor :invoice, :sales_book_invoice

			validates :root, presence: true, inclusion: { in: ['InvoiceRequest'] }
			validate do
				errors.add(:invoice, 'can\'t be blank if Sales book invoice is also blank') if (invoice.nil? || invoice.empty?) && (sales_book_invoice.nil? || sales_book_invoice.empty?)
				errors.add(:sales_book_invoice, 'must be blank if Invoice is not blank') if !(invoice.nil? || invoice.empty?) && !(sales_book_invoice.nil? || sales_book_invoice.empty?)
			end

			def initialize
				super
				@root = 'InvoiceRequest'
				@invoice = Furs::Models::Invoice.new
				@sales_book_invoice = Furs::Models::SalesBookInvoice.new
			end
		end
	end
end