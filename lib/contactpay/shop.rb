# frozen_string_literal: true

require "contactpay/config"
require "contactpay/client"

module Contactpay
  # Shop API
  class Shop < Client
    def balance
      path = "/gateway/v1/shop_balance"
      signature_fields = %w[
        now
        shop_id
      ]
      send_request(path: path, options: {
                     signature_fields: signature_fields,
                     time_now: true
                   })
    end
  end
end
