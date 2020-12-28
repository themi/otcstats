require 'rails_helper'

RSpec.describe Envisage::Members do

  subject(:api) { described_class.new(org_token) }

  let(:response) { Net::HTTPSuccess.new(1.0, '200', 'OK') }
  let(:body) { "{ \"records\": 20 }" }

  before {
    expect_any_instance_of(Net::HTTP).to receive(:request) { response }
    expect(response).to receive(:body) { body }
  }

  let(:org_token) { "abc123xyx" }

  it "get operates ok" do
    api.get
    expect(api.response_body).to include("records" => 20)
    expect(api.error?).to be false
  end

  it "post operates ok" do
    api.post
    expect(api.response_body).to include("records" => 20)
    expect(api.error?).to be false
  end

end
