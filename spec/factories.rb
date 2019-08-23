FactoryBot.define do
  # echo
  factory :echo_request, class: 'Furs::Models::EchoRequest' do
    echo_request { "echo echo echo" }
  end

  # business premise
  factory :address, class: 'Furs::Models::Address' do
  	street { "Test street" }
  	house_number { "102" }
  	house_number_additional { nil }
  	community { "Test community" }
  	city { "Test city" }
    postal_code { "1000" }
  end

  factory :immovable_b_p_identifier, aliases: [:b_p_identifier], class: 'Furs::Models::BPIdentifier' do
  	real_estate_b_p
  end
  
  factory :movable_b_p_identifier, class: 'Furs::Models::BPIdentifier' do
  	premise_type { 'A' }
  	real_estate_b_p { nil }
  end

  factory :real_estate_b_p, class: 'Furs::Models::RealEstateBP' do
  	property_i_d
  	address
  end

  factory :property_i_d, class: 'Furs::Models::PropertyID' do
  	cadastral_number { 365 }
  	building_number { 12 }
  	building_section_number { 6 }
  end

  factory :business_premise_request, class: 'Furs::Models::BusinessPremiseRequest' do
  	business_premise
  end

  factory :business_premise, class: 'Furs::Models::BusinessPremise' do
  	business_premise_i_d { 'PREMISE'}
  	b_p_identifier
  	validity_date { "2029-07-08" }
  	software_supplier { build_list :software_supplier, 1 }
  	special_notes { nil }
  	closing_tag { nil }
  end

  factory :domestic_software_supplier, aliases: [:software_supplier], class: 'Furs::Models::SoftwareSupplier' do 
    tax_number { 12345678 }
  end

  factory :foreign_software_supplier, class: 'Furs::Models::SoftwareSupplier' do 
    name_foreign { 'Test company' }
  end

  # invoice
  factory :invoice_request, class: 'Furs::Models::InvoiceRequest' do
    invoice
    sales_book_invoice { nil }
  end

  factory :sales_book_invoice_request, class: 'Furs::Models::InvoiceRequest' do
    invoice { nil }
    sales_book_invoice
  end

  factory :base_invoice, class: 'Furs::Models::BaseInvoice' do
    # customer_v_a_t_number { 12345678 }
    invoice_amount { 66.71 }
    payment_amount { 1047.76 }
    taxes_per_seller{ build_list :taxes_per_seller, 1 }
    reference_sales_book { [] }
    reference_invoice { [] }
  end

  factory :taxes_per_seller, class: 'Furs::Models::TaxesPerSeller' do
    v_a_t { build_list :v_a_t, 1 }
    flat_rate_compensation { build_list :flat_rate_compensation, 1 }
    # other_taxes_amount
    # exempt_v_a_t_taxable_amount
    # reverse_v_a_t_taxable_amount
    # non_taxable_amount
    # special_tax_rules_amount
  end

  factory :v_a_t, class: 'Furs::Models::VAT' do
    tax_rate { 22.0 }
    taxable_amount { 23.04 }
    tax_amount { 5.09 }
  end

  factory :flat_rate_compensation, class: 'Furs::Models::FlatRateCompensation' do
    flat_rate_rate { 111.11 }
    flat_rate_taxable_amount { 123.43 }
    flat_rate_amount { 45.33 }
  end

  factory :reference_sales_book, class: 'Furs::Models::ReferenceSalesBook' do
    reference_sales_book_identifier
    # reference_sales_book_issue_date
  end

  factory :sales_book_identifier, aliases: [:reference_sales_book_identifier], class: 'Furs::Models::SalesBookIdentifier' do
    invoice_number { "INVOICE-1" }
    set_number { 21 }
    serial_number { 123456654321 }
  end

  factory :reference_invoice, class: 'Furs::Models::ReferenceInvoice' do
    reference_invoice_identifier
    # reference_invoice_issue_date_time
  end

  factory :invoice_identifier, aliases: [:reference_invoice_identifier], class: 'Furs::Models::InvoiceIdentifier' do
    business_premise_i_d { "PREMISE" }
    electronic_device_i_d { "POS" }
    invoice_number { "27" }
  end

  factory :invoice, parent: :base_invoice, class: 'Furs::Models::Invoice' do
    issue_date_time { Time.now.strftime("%Y-%m-%dT%H:%M:%S") }
    numbering_structure { "B" }
    invoice_identifier
    operator_tax_number { 12345678 }
    # operator_tax_number
    # foreign_operator { 0 }
    protected_i_d { SecureRandom.hex 16 }
    # subsequent_submit { 0 }
  end

  factory :sales_book_invoice, parent: :base_invoice, class: 'Furs::Models::SalesBookInvoice' do
    issue_date { "2019-08-12" }
    sales_book_identifier
    business_premise_i_d { "PREMISE" }
  end

  # general
  factory :header, class: 'Furs::Models::Header' do
  end

  factory :base_request, class: 'Furs::Models::BaseRequest' do 
  end

  factory :base_request_with_header, class: 'Furs::Models::BaseRequestWithHeader' do 
  end
end