# frozen_string_literal: true

module Contactpay
  # Configuration storage
  class Config
    attr_accessor :base_url, :account_secret_key, :shop_id, :faraday_block

    def initialize
      @base_url = nil
      @account_secret_key = nil
      @shop_id = nil
      @faraday_block = nil
    end
  end
end
