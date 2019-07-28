module Furs
	module Models
		class InvoiceRequest < Furs::Models::BaseRequest

			attr_accessor :invoice, :sales_book_invoice
			attr_reader :header

			validate do
				errors.add(:base, 'Only one of the fields can be blank') if (invoice.empty? && sales_book_invoice.empty?) || (!invoice.empty? && !sales_book_invoice.empty?)
			end

			def initialize
				@root = 'InvoiceRequest'
				@header = Furs::Models::Header.new
				@invoice = Furs::Models::Invoice.new
				@sales_book_invoice = Furs::Models::SalesBookInvoice.new
			end
		end
	end
end