module Furs
	module Models
		class SalesBookInvoice < Furs::Models::BaseInvoice

			attr_accessor :issue_date, :sales_book_identifier, :business_premise_i_d

			validates :issue_date, presence: true, format: Furs::Constant::DATE_REGEX
			validates :sales_book_identifier, presence: true
			validates :business_premise_i_d, presence: true, format: Furs::Constant::ALPHANUMERIC_REGEX, length: 1..20

			def initialize
				super
				@sales_book_identifier = Furs::Models::SalesBookIdentifier.new
			end

		end
	end
end