# frozen_string_literal: true

require "contactpay/config"
require "contactpay/client"

module Contactpay
  # Shop API
  class Shop < Client
    def balance(data)
      path = "/gateway/v1/shop_balance"
      signature_fields = %w(
        now
        shop_id
      )
      send_request(path: path, body: data, signature_fields: signature_fields)
    end
  end
end