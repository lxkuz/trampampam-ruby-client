# frozen_string_literal: true

require "spec_helper"

RSpec.describe Contactpay::Shop do
  let(:invoice) { described_class.new }
  let(:shop_id) { 357 }
  let(:secret_key) { "593156648d1c420dad278c4e723b5741" }

  before do
    Contactpay.configure do |config|
      config.base_url = "https://api-test.contactpay.io"
      config.account_secret_key = secret_key
      config.shop_id = shop_id
    end

    Timecop.freeze(Time.parse("2023-07-18T13:23:41"))
  end

  describe "#balance" do
    subject(:result) { invoice.balance }

    context "when request_data is valid", vcr: "shop/balance_ok" do
      let(:response) do
        {
          "data" => {
            "balances" => [
              { "available" => 5889.25, "currency" => 978, "frozen" => 0.0, "hold" => 0.0 },
              { "available" => 4388.6, "currency" => 643, "frozen" => 0.0, "hold" => 0.0 },
              { "available" => 3285.8, "currency" => 840, "frozen" => 0.0, "hold" => 0.0 }
            ],
            "shop_id" => shop_id
          },
          "error_code" => 0,
          "message" => "Ok",
          "result" => true
        }
      end

      it "returns request data" do
        expect(result).to eql(response)
      end
    end

    context "when shop_id is wrong", vcr: "shop/balance_shop_not_found" do
      let(:shop_id) { 22_222_222_222 }

      let(:response) do
        {
          "data" => nil,
          "error_code" => 11,
          "message" => "Shop (id = 22222222222) is not found",
          "result" => false
        }
      end

      it "returns error" do
        expect(result).to eql(response)
      end
    end

    context "when secret key is wrong", vcr: "shop/balance_wrong_secret" do
      let(:secret_key) { "wrong" }

      let(:response) do
        {
          "data" => nil,
          "error_code" => 10,
          "message" =>
          "Incorrect values for parameters: sign=\"Invalid sign, string to sign: \"2023-07-18T13:23:41:357\"\"",
          "result" => false
        }
      end

      it "returns error" do
        expect(result).to eql(response)
      end
    end
  end
end
