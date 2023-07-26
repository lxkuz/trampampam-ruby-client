# frozen_string_literal: true

# Base implementation of the MTN API client

# Includes methods common to collections, disbursements and remittances

require 'faraday'
require 'digest'

require 'contactpay/config'
require 'contactpay/errors'

module Contactpay
  # Base API client
  class Client
    def initialize(config)
      @config = config
    end

    def send_request(path:, headers: {}, body: {}, options: {})
      conn = faraday_with_block(url: @config.base_url)
      conn.headers = default_headers.merge(headers)
      response = conn.post(path, prepare_body(body, options).to_json)
      interpret_response(response)
    end

    def interpret_response(resp)
      body = resp.body.empty? ? '' : JSON.parse(resp.body)
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

    private

    def prepare_body(body, options)
      signature_fields = options[:signature_fields] || []
      time_now = options[:time_now]
      result = { 'shop_id' => @config.shop_id }
      result['now'] = build_time_now if time_now
      result.merge!(body)
      result['sign'] = generate_sign(result, signature_fields)
      result
    end

    def default_headers
      {
        'Content-Type' => 'application/json; charset=utf-8',
        'accept' => 'application/json'
      }
    end

    def generate_sign(body, signature_fields)
      signature_fields_hash = body.slice(*signature_fields)
      line = Hash[signature_fields_hash.sort].values.join(':') + @config.account_secret_key
      Digest::SHA2.hexdigest line
    end

    def faraday_with_block(options)
      Faraday.new(options)
      block = @config.faraday_block
      if block
        Faraday.new(options, &block)
      else
        Faraday.new(options)
      end
    end

    def build_time_now
      Time.now.strftime('%Y-%m-%dT%H:%M:%S')
    end
  end
end
