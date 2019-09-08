require 'spec_helper'

RSpec.describe Furs::Models::ReferenceInvoiceIdentifier do

  it 'inherits from Furs::Models::InvoiceIdentifier' do
    expect(Furs::Models::ReferenceInvoiceIdentifier).to be < Furs::Models::InvoiceIdentifier
  end
end