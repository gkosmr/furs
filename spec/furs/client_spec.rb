require 'spec_helper'

RSpec.describe Furs::Client do

	let(:client) { Furs::Client.new(Furs.config) }

	it 'includes HTTParty module' do
		expect(Furs::Client).to include(HTTParty)
	end

	[:echo, :register_business_premise, :issue_invoice].each do |method|
	    it "responds to #{method} method" do
	      expect(Furs).to respond_to(method).with(1).argument
	    end
  	end

  	it '#echo raises an error if data is invalid' do
  		data = build(:echo_request, echo_request: nil)
  		expect{client.echo(data)}.to raise_error(Exceptions::InvalidData)
  	end

  	it '#echo receives the right response' do
  		VCR.use_cassette('echo') do 
	  		data = build(:echo_request, echo_request: 'Test Echo')
	  		txt = client.echo data
	  		expect(WebMock).to have_requested(:post, Furs.config.base_url+"/v1/cash_registers/echo").with(headers: { "Content-Type" => "application/json; charset=UTF-8" })
	  		expect(txt).to eq('Test Echo')
  		end
  	end

  	it '#register_business_premise raises an error if data is invalid' do
  		data = build(:business_premise_request, business_premise: nil)
  		expect{client.register_business_premise(data)}.to raise_error(Exceptions::InvalidData)
  	end

  	it '#register_business_premise receives the right response' do
  		VCR.use_cassette('business_premise') do 
	  		data = build(:business_premise_request)
	  		obj = client.register_business_premise data
	  		expect(WebMock).to have_requested(:post, Furs.config.base_url+"/v1/cash_registers/invoices/register").with(headers: { "Content-Type" => "application/json; charset=UTF-8" })
	  		expect(obj.error).to be(nil)
	  		expect(obj.header).not_to be(nil)
  		end
  	end

  	it '#register_business_premise returns api error if incorrect tax number is used' do
  		old_tax_number = Furs.config.tax_number
  		Furs.configure { |config| config.tax_number = 12345678 }
  		VCR.use_cassette('business_premise_incorrect_tax_number') do 
	  		data = build(:business_premise_request)
	  		obj = client.register_business_premise data
	  		expect(WebMock).to have_requested(:post, Furs.config.base_url+"/v1/cash_registers/invoices/register").with(headers: { "Content-Type" => "application/json; charset=UTF-8" })
	  		expect(obj.error).not_to be(nil)
	  		expect(obj.header).not_to be(nil)
  		end
  		Furs.configure { |config| config.tax_number = old_tax_number }
  	end

  	it '#issue_invoice raises an error if data is invalid' do
  		data = build(:invoice_request, invoice: nil, sales_book_invoice: nil)
  		expect{client.issue_invoice(data)}.to raise_error(Exceptions::InvalidData)
  	end

  	it '#issue_invoice receives the right response' do
  		VCR.use_cassette('invoice') do 
	  		data = build(:invoice_request)
	  		obj = client.issue_invoice data
	  		expect(WebMock).to have_requested(:post, Furs.config.base_url+"/v1/cash_registers/invoices").with(headers: { "Content-Type" => "application/json; charset=UTF-8" })
	  		expect(obj.error).to be(nil)
	  		expect(obj.header).not_to be(nil)
  		end
  	end

    it '#issue_invoice generates ZOI automatically and receives the right response' do
      VCR.use_cassette('invoice_without_zoi') do 
        data = build(:invoice_request, invoice: build(:invoice, protected_i_d: nil))
        obj = client.issue_invoice data
        expect(WebMock).to have_requested(:post, Furs.config.base_url+"/v1/cash_registers/invoices").with(headers: { "Content-Type" => "application/json; charset=UTF-8" })
        expect(obj.error).to be(nil)
        expect(obj.header).not_to be(nil)
      end
    end
end