require 'rails_helper'

RSpec.describe Envisage::Members do

  subject(:api) { described_class.new(org_token) }
  let(:org_token) { "abc123xyx" }

  let(:response) { Net::HTTPSuccess.new(1.0, '200', 'OK') }

  before {
    expect_any_instance_of(Net::HTTP).to receive(:request) { response }
    expect(response).to receive(:body) { body }
  }

  context "with method get" do
    let(:body) { "{ \"records\": 20 }" }
    it "get operates ok" do
      api.get
      expect(api.response_body).to include("records" => 20)
      expect(api.error?).to be false
    end
  end

  context "with method post" do
    let(:body) { "{ \"thumbsup\": 3 }" }
    it "post operates ok" do
      api.post
      expect(api.response_body).to include("thumbsup" => 3)
      expect(api.error?).to be false
    end
  end
end

# probably a bit perdantic but it gave me 100% coverage \o/
RSpec.describe Envisage::Base do

  class Dumby < Envisage::Base;end

  context "with undefined `resource_path`" do
    it "throws an error" do
      expect{ Dumby.new.get }.to raise_error NotImplementedError
    end
  end
end
