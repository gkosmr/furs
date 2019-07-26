require "active_support/core_ext/string"
require "active_model"
require 'json'

module Furs
	module Models
		class BaseRequest
			include ActiveModel::Validations

			attr_accessor :root

			def as_json
	            data = self.instance_variables.inject({}) do |hsh, attribute| 
	            	key = attribute.to_s.gsub('@','').camelize
	            	tmp = self.instance_variable_get(attribute)
	            	if tmp.is_a? Array
	            		hsh.merge( key => tmp.map{ |el| to_val(el) } )
	            	else
		            	val = to_val(tmp)
		            	val.nil? || %w(Root Errors).include?(key) || ( val.is_a?(Array) && val.length == 0 ) || ( tmp.class < Furs::Models::BaseRequest && tmp.empty? ) ? hsh : hsh.merge( key => val )
	            	end
	            end

	            root.nil? ? data : { root => data }
            end
		
		    def to_json
		        as_json.to_json
		    end

		    def valid?
		    	super && self.instance_variables.map{ |attribute| self.instance_variable_get(attribute) }.select{ |val| val.class < Furs::Models::BaseRequest }.all?{ |val| val.nil? || val.valid? }
		    end

		    def empty?
		    	self.instance_variables.all? do |attribute| 
		    		val = self.instance_variable_get(attribute)
		    		val.nil? || ( val.class < Furs::Models::BaseRequest && val.empty? )
		    	end
		    end

		    private

		    	def to_val tmp
		    		tmp.class < Furs::Models::BaseRequest ? tmp.as_json : tmp
		    	end
	    end
	end
end