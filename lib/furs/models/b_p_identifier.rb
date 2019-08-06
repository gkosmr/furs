module Furs
	module Models
		class BPIdentifier < Furs::Models::BaseRequest

			attr_accessor :real_estate_b_p, :premise_type

			validates :premise_type, allow_blank: true, inclusion: { in: %w(A B C) }
			validate do
				errors.add(:real_estate_b_p, 'can\'t be blank if Premise type is also blank') if (real_estate_b_p.nil? || real_estate_b_p.empty?) && premise_type.nil?
				errors.add(:premise_type, 'must be blank if Real estate BP is not blank') if !(real_estate_b_p.nil? || real_estate_b_p.empty?) && !premise_type.nil?
			end

			def initialize
				@real_estate_b_p = Furs::Models::RealEstateBP.new
			end
		end
	end
end