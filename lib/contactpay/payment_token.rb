# frozen_string_literal: true

require "contactpay/config"
require "contactpay/client"

module Contactpay
  # PaymentToken API
  class PaymentToken < Client
    def create(data)
      path = "/gateway/v1/payment-token/create"
      signature_fields = %w(
        payway
        shop_id
        shop_request_id
      )
      send_request(path: path, body: data, signature_fields: signature_fields)
    end

    def status(data)
      path = "gateway/v1/payment-token/status"
      signature_fields = if data['token'].present?
        %w(now token)
      else
        %w(now shop_id shop_request_id)
      end
      send_request(path: path, body: data, signature_fields: signature_fields)
    end

    def complete(data, session_uid)
      path = "gateway/v1/payment-token/complete/#{session_uid}"
      # TODO: figure out signature_fields
      send_request(path: path, body: data, signature_fields: nil)
    end

    def delete(data)
      path = "gateway/v1/payment-token/delete"
      signature_fields = %w(
        token
      )
      send_request(path: path, body: data, signature_fields: signature_fields)
    end
  end
end