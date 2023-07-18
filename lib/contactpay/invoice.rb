# frozen_string_literal: true

require "contactpay/config"
require "contactpay/client"

module Contactpay
  # Invoice API
  class Invoice < Client
    def prelim_calc(data)
      path = "/gateway/v1/invoice/try"
      signature_fields = %w(
        amount
        currency
        payway
        shop_id
        shop_order_id
      )
      send_request(path: path, body: data, options: {
        signature_fields: signature_fields
      })
    end

    def create(data)
      path = "/gateway/v1/invoice/create"
      signature_fields = %w(
        amount
        currency
        payway
        shop_id
        shop_order_id
      )
      send_request(path: path, body: data, options: {
        signature_fields: signature_fields
      })
    end

    def status(data)
      path = "/gateway/v1/invoice/check"
      signature_fields = %w(
        now
        shop_id
        shop_order_id
      )
      send_request(path: path, body: data, options: {
        signature_fields: signature_fields,
        time_now: true
      })
    end

    def hold_funds(data)
      path = "/gateway/v1/invoice/hold"
      signature_fields = %w(
        amount
        currency
        payway
        shop_id
        shop_order_id
      )
      send_request(path: path, body: data, options: {
        signature_fields: signature_fields
      })
    end

    def charge(data)
      path = "/gateway/v1/invoice/charge"
      signature_fields = %w(
        invoice_id
        now
        shop_id
      )
      send_request(path: path, body: data, options: {
        signature_fields: signature_fields,
        time_now: true
      })
    end

    def unhold_funds(data)
      path = "/gateway/v1/invoice/unhold"
      signature_fields = %w(
        invoice_id
        now
        shop_id
      )
      send_request(path: path, body: data, options: {
        signature_fields: signature_fields,
        time_now: true
      })
    end

    def payment_methods(data)
      path = "/gateway/v1/shop_input_config/shop"
      signature_fields = %w(
        now
        shop_id
      )
      send_request(path: path, body: data, options: {
        signature_fields: signature_fields,
        time_now: true
      })
    end
  end
end