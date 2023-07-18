# frozen_string_literal: true

require "spec_helper"

RSpec.describe Contactpay::Withdraw do
  before do
    Contactpay.configure do |config|
      config.base_url = "https://api-test.contactpay.io"
      config.account_secret_key = "593156648d1c420dad278c4e723b5741"
      config.shop_id = 357
    end

    Timecop.freeze(Time.parse("2023-07-18T13:23:41"))
  end

  let(:withdraw) { described_class.new }

  describe "#prelim_calc" do
    subject(:result) { withdraw.prelim_calc(request_data) }

    context "when request_data is valid", vcr: "withdraw/prelim_calc" do
      let(:request_data) do
        {
          "shop_currency" => 643,
          "payway" => "qiwi_topup_rub_to_wallet[mock_server,success]",
          "amount" => 100.23,
          "amount_type" => "ps_amount"
        }
      end

      let(:response) do
        {
          "data" => {
            "account_info_config" => {
              "account" => {
                "regex" => "^[0-9]{11,12}$",
                "title" => "your account"
              }
            },
            "info" => {},
            "payee_receive" => 100.23,
            "ps_currency" => 643,
            "shop_currency" => 643,
            "shop_write_off" => 102.23
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
  end

  describe "#payment_methods" do
    subject(:result) { withdraw.payment_methods }

    context "when request_data is valid", vcr: "withdraw/payment_methods" do
      let(:response) do
        {
          "data" => [{
            "id" => 1,
            "name" => "Test pay method",
            "payways" => [
              {
                "account_info_config" => {
                  "account" => { "regex" => "^[0-9]{11,12}$",
                                 "title" => "your account" }
                },
                "alias" => "qiwi_topup_rub_to_wallet[mock_server,success]",
                "currency" => 643, "fee_config" => { "fix" => 0.0, "percent" => 2.0 },
                "max_amount" => 100_000.0, "min_amount" => 5.0
              },
              {
                "account_info_config" => {
                  "account" => {
                    "regex" => "^[0-9]{13,19}$", "title" => "your account"
                  },
                  "phone" => { "regex" => "\\d+",
                               "title" => "customer phone" }
                },
                "alias" => "qiwi_topup_rub_to_card[mock_server,success]",
                "currency" => 643, "fee_config" => { "fix" => 0.0, "percent" => 2.0 },
                "max_amount" => 10_000.0, "min_amount" => 5.0
              },
              { "account_info_config" => {
                  "account" => { "regex" => "^[0-9]{11,12}$",
                                 "title" => "your account" }
                },
                "alias" => "qiwi_topup_rub_to_wallet[mock_server,fail]", "currency" => 643,
                "fee_config" => {
                  "fix" => 0.0, "percent" => 2.0
                },
                "max_amount" => 10_000.0, "min_amount" => 1.0 },
              { "account_info_config" => { "account" => {
                "regex" => "^[0-9]{11,12}$",
                "title" => "your account"
              } },
                "alias" => "qiwi_topup_rub_to_wallet[mock_server,internal_server_error]",
                "currency" => 643, "fee_config" => { "fix" => 0.0, "percent" => 2.0 },
                "max_amount" => 10_000.0, "min_amount" => 1.0 },
              { "account_info_config" => { "account" => {
                "regex" => "^[0-9]{11,12}$", "title" => "your account"
              } },
                "alias" => "qiwi_topup_rub_to_wallet[mock_server,wallet_does_not_exist]",
                "currency" => 643, "fee_config" => { "fix" => 0.0, "percent" => 2.0 },
                "max_amount" => 10_000.0, "min_amount" => 1.0 },
              {
                "account_info_config" => {
                  "account" => { "regex" => "^[0-9]{13,19}$",
                                 "title" => "your account" },
                  "phone" => { "regex" => "\\d+",
                               "title" => "customer phone" }
                },
                "alias" => "qiwi_topup_rub_to_card[mock_server,payment_forbidden]",
                "currency" => 643, "fee_config" => { "fix" => 0.0, "percent" => 2.0 },
                "max_amount" => 10_000.0, "min_amount" => 1.0
              }
            ],
            "rating" => 1
          }],
          "error_code" => 0,
          "message" => "Ok",
          "result" => true
        }
      end

      it "returns request data" do
        expect(result).to eql(response)
      end
    end
  end

  describe "#check_account" do
    subject(:result) { withdraw.check_account(request_data) }

    context "when request_data is valid", vcr: "withdraw/check_account" do
      let(:request_data) do
        {
          "payway" => "qiwi_topup_rub_to_wallet[mock_server,success]",
          "amount" => 100.23,
          "account" => "79991112233"
        }
      end

      let(:response) do
        {
          "data" => {
            "account_info" => nil, "provider_status" => 1, "result" => true
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
  end

  describe "#create" do
    subject(:result) { withdraw.create(request_data) }

    context "when request_data is valid", vcr: "withdraw/create" do
      let(:request_data) do
        {
          "shop_currency" => 643,
          "payway" => "qiwi_topup_rub_to_wallet[mock_server,success]",
          "amount" => 100.23,
          "account" => "79991112233",
          "amount_type" => "ps_amount",
          "shop_payment_id" => "shop_payment_111",
          "description" => "It's payout for my friend"
        }
      end

      let(:response) do
        {
          "data" => {
            "balance" => 20_000.0,
            "id" => 48_581_287,
            "payee_receive" => 100.23,
            "ps_currency" => 643,
            "shop_currency" => 643,
            "shop_payment_id" => "shop_payment_111",
            "shop_write_off" => 102.23,
            "status" => 3
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
  end

  describe "#status_by_shop_number" do
    subject(:result) { withdraw.status_by_shop_number(request_data) }

    context "when request_data is valid", vcr: "withdraw/status_by_shop_number" do
      let(:request_data) do
        {
          "shop_payment_id" => "shop_payment_111"
        }
      end

      let(:response) do
        {
          "data" => {
            "error_code" => 0,
            "id" => 48_581_287,
            "payee_receive" => 100.23,
            "ps_currency" => 643,
            "shop_currency" => 643,
            "shop_payment_id" => "shop_payment_111",
            "shop_write_off" => 102.23,
            "status" => 5
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
  end

  describe "#status_by_id" do
    subject(:result) { withdraw.status_by_id(request_data) }

    context "when request_data is valid", vcr: "withdraw/status_by_id" do
      let(:request_data) do
        {
          "withdraw_id" => "48581287"
        }
      end

      let(:response) do
        {
          "data" => {
            "error_code" => 0,
            "id" => 48_581_287,
            "payee_receive" => 100.23,
            "ps_currency" => 643,
            "shop_currency" => 643,
            "shop_payment_id" => "shop_payment_111",
            "shop_write_off" => 102.23,
            "status" => 5
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
  end
end
