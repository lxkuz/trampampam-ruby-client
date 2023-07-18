# frozen_string_literal: true

require "contactpay/config"
require "contactpay/client"

module Contactpay
  # Withdraw API
  class Withdraw < Client
    def prelim_calc(data)
      path = "/gateway/v1/withdraw/try"
      signature_fields = %w(
        amount
        amount_type
        payway
        shop_currency
        shop_id
      )
      send_request(path: path, body: data, signature_fields: signature_fields)
    end

    def check_account(data)
      path = "/gateway/v1/check_account"
      signature_fields = %w(account amount payway shop_id)
      send_request(path: path, body: data, signature_fields: signature_fields)
    end

    def create(data)
      path = "/gateway/v1/withdraw/create"
      signature_fields = %w(
        account
        amount
        amount_type
        payway
        shop_currency
        shop_id
        shop_payment_id
      )
      send_request(path: path, body: data, signature_fields: signature_fields)
    end

    def status_by_id(data)
      path = "/gateway/v1/withdraw/status"
      signature_fields = %w(
        now
        shop_id
        withdraw_id
      )
      send_request(path: path, body: data, signature_fields: signature_fields)
    end

    def status_by_shop_number(data)
      path = "/gateway/v1/withdraw/shop_payment_status"
      signature_fields = %w(
        now
        shop_id
        shop_payment_id
      )
      send_request(path: path, body: data, signature_fields: signature_fields)
    end

    def payment_methods
      data = { 'now' => time_now }
      path = "/gateway/v1/shop_output_config/shop"
      signature_fields = %w(
        now
        shop_id
      )
      send_request(path: path, body: data, signature_fields: signature_fields)
    end
  end
end
