# frozen_string_literal: true

require "spec_helper"

RSpec.describe Contactpay::Invoice do
  before do
    Contactpay.configure do |config|
      config.base_url = "https://api-test.contactpay.io"
      config.account_secret_key = "593156648d1c420dad278c4e723b5741"
      config.shop_id = 357
    end

    Timecop.freeze(Time.parse("2023-07-18T13:23:41"))
  end

  let(:invoice) { described_class.new }

  xdescribe "#prelim_calc" do
    subject(:result) { invoice.prelim_calc(request_data) }

    context "when request_data is valid", vcr: "invoice/prelim_calc" do
      let(:request_data) do
        {
          "shop_order_id" => "117",
          "amount" => "299.45",
          "currency" => 840,
          "payway" => "wallet_usd",
          "description" => "Testing invoices"
        }
      end

      let(:response) do
        {}
      end

      it "returns request data" do
        expect(result).to eql(response)
      end
    end
  end
end
