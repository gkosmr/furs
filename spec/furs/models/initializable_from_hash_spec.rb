require 'spec_helper'

RSpec.describe Furs::Models::InitializableFromHash do

	it '#initialize_from_hash method converts hash to object correctly' do 
		data = {"TaxNumber"=>10523766, "BPIdentifier"=>{"RealEstateBP"=>{"PropertyID"=>{"CadastralNumber"=>365, "BuildingNumber"=>12, "BuildingSectionNumber"=>6}, "Address"=>{"Street"=>"Test street", "HouseNumber"=>"102", "Community"=>"Test community", "City"=>"Test city", "PostalCode"=>"1000"}}}, "SoftwareSupplier"=>[{"TaxNumber"=>12345678}], "BusinessPremiseID"=>"PREMISE", "ValidityDate"=>"2029-07-08"}

		obj = Furs::Models::BusinessPremise.initialize_from_hash data
		expect(obj.b_p_identifier).not_to be(nil)		
		expect(obj.b_p_identifier.real_estate_b_p).not_to be(nil)
		expect(obj.b_p_identifier.real_estate_b_p.address).not_to be(nil)
		expect(obj.b_p_identifier.real_estate_b_p.address.street).to eq("Test street")
		expect(obj.software_supplier).not_to be(nil)
		expect(obj.software_supplier.size).to eq(1)	
	end
end