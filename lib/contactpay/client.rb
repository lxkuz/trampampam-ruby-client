# frozen_string_literal: true

# Base implementation of the MTN API client

# Includes methods common to collections, disbursements and remittances

require "faraday"
require "digest"

require "contactpay/config"
require "contactpay/errors"

module Contactpay
  # Base API client
  class Client
    def send_request(path:, headers: {}, body: nil, signature_fields: [])
      conn = faraday_with_block(url: Contactpay.config.base_url)
      conn.headers = default_headers.merge(headers)
      response = conn.post(path, sign_body(body, signature_fields).to_json)
      interpret_response(response)
    end

    def interpret_response(resp)
      body = resp.body.empty? ? "" : JSON.parse(resp.body)
      response = {
        body: body,
        code: resp.status
      }
      handle_error(response[:body], response[:code]) unless resp.status >= 200 && resp.status < 300
      body
    end

    def handle_error(response_body, response_code)
      raise Contactpay::Error.new(response_body, response_code)
    end

    def prepare_get_request(path)
      headers = {}
      send_request("get", path, headers)
    end

    private

    def sign_body(body, signature_fields)
      body.merge({
        'sign' => generate_sign(body, signature_fields)
      })
    end

    def default_headers
      {
        "Content-Type" => "application/json; charset=utf-8",
        "accept" => "application/json"
      }
    end

    def generate_sign(body, signature_fields)
      signature_fields_hash = body.slice(*signature_fields)
      key = Contactpay.config.account_secret_key
      line = Hash[signature_fields_hash.sort].values.join(':') + key
      Digest::SHA2.hexdigest line
    end

    def faraday_with_block(options)
      Faraday.new(options)
      block = Contactpay.config.faraday_block
      if block
        Faraday.new(options, &block)
      else
        Faraday.new(options)
      end
    end
  end
end