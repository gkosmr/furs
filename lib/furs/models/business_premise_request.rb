module Furs
	module Models
		class BusinessPremiseRequest < Furs::Models::BaseRequestWithHeader

			attr_accessor :business_premise

			validates :root, inclusion: { in: ['BusinessPremiseRequest'] }
			validates :business_premise, presence: true

			def initialize
				super
				@root = 'BusinessPremiseRequest'
				@business_premise = Furs::Models::BusinessPremise.new
			end
		end
	end
end