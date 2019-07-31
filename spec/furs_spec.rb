RSpec.describe Furs do

	before(:each) do
    configure_test_data
	end

  after(:all) do 
    configure_test_data
  end
  
  it "has a version number" do
    expect(Furs::VERSION).not_to be nil
  end

  it '#configure sets the configuration properties' do
  	Furs.configure do |config|
  		config.base_url = 'www.test.com'
  		config.tax_number = '12345678'
  	end

  	expect(Furs.config.base_url).to eq('www.test.com')
  	expect(Furs.config.tax_number).to eq('12345678')
  end

  it "#client initializes furs client if all configuration properties are set" do 
    expect(Furs.send(:client)).to be_instance_of(Furs::Client)
  end

  it "#client raises InvalidConfiguration exception if any of the properties is not configured" do 
  	Furs.instance_variable_set(:@client, nil)
  	random_var = Furs.config.instance_variables.sample.to_s.gsub('@', '')
    Furs.configure { |config| config.send("#{random_var}=", nil) }

    expect{ Furs.send(:client) }.to raise_error(Exceptions::InvalidConfiguration)
  end

  [[:echo, :echo_request], [:register_business_premise, :business_premise_request], [:issue_invoice, :invoice_request]].each do |(method, factory)|
    it "responds to #{method} method" do
      expect(Furs).to respond_to(method).with(1).argument
    end

    it "##{method} works without errors" do
      VCR.use_cassette(method) do 
        expect{ Furs.send method, build(factory) }.not_to raise_error
      end
    end
  end
end
