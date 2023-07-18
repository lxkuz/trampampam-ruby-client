# frozen_string_literal: true

require "contactpay/config"
require "contactpay/client"

module Contactpay
  # refund API
  class Refund < Client
    def create(data)
      path = "/gateway/v1/invoice/create-refund"
      signature_fields = %w(
        amount
        invoice_id
        shop_id
        shop_refund_id
      )
      send_request(path: path, body: data, options: {
        signature_fields: signature_fields
      })
    end

    def status(data)
      path = "/gateway/v1/invoice/get-refunds"
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
  end
end