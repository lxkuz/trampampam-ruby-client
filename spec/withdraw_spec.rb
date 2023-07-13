# frozen_string_literal: true

require "spec_helper"
require "pry"

RSpec.describe Contactpay::Withdraw do
  before do
    Contactpay.configure do |config|
      config.base_url = "https://api.contactpay.com"
      config.account_secret_key = "account-secret-key"
    end
  end

  let(:withdraw) { described_class.new }

  xdescribe "#prelim_calc" do
    subject(:result) { withdraw.prelim_calc(request_data) }

    context "when request_data is valid", vcr: "withdraw/prelim_calc" do

      let(:request_data) do
        {
          "shop_id" => 79834981,
          "shop_order_id"  => "117",
          "amout" => "299.45",
          "currency" => 840,
          "payway" => "wallet_usd",
          "description" => "Testing invoices"
        }
      end

      let(:response) do
        {
        }
      end

      it 'returns request data' do
        expect(result).to eql(response)
      end
    end
  end
end