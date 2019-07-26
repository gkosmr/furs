module Furs
	module Models
		class BusinessPremiseRequest < Furs::Models::BaseRequest

			attr_accessor :business_premise
			attr_reader :header

			def initialize
				@root = 'BusinessPremiseRequest'
				@header = Furs::Models::Header.new
				@business_premise = Furs::Models::BusinessPremise.new
			end
		end
	end
end