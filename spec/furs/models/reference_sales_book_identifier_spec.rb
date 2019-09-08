require 'spec_helper'

RSpec.describe Furs::Models::ReferenceSalesBookIdentifier do

  it 'inherits from Furs::Models::SalesBookIdentifier' do
    expect(Furs::Models::ReferenceSalesBookIdentifier).to be < Furs::Models::SalesBookIdentifier
  end
end