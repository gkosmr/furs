require 'spec_helper'

RSpec.describe ActiveSupport::Inflector do

	it '#underscore returns real underscored string if use_acronym = false' do
		expect(ActiveSupport::Inflector.underscore('SSLError')).to eq('ssl_error')
		expect(ActiveSupport::Inflector.underscore('SSLError', false)).to eq('s_s_l_error')
	end
end

RSpec.describe String do

	it '#underscore returns real underscored string if use_acronym = false' do
		expect('SSLError'.underscore).to eq('ssl_error')
		expect('SSLError'.underscore false).to eq('s_s_l_error')
	end
end