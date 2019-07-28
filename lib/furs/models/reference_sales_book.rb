module Furs
	module Models
		class ReferenceSalesBook < Furs::Models::BaseRequest

			attr_accessor :reference_sales_book_identifier, :reference_sales_book_issue_date

			validates :reference_sales_book_issue_date, allow_blank: true, format: Furs::Constant::DATE_REGEX

			def initialize
				@reference_sales_book_identifier = Furs::Models::SalesBookIdentifier.new
			end

		end
	end
end