# frozen_string_literal: true

module Contactpay
  # Configuration storage
  class Config
    attr_accessor :base_url, :account_secret_key, :shop_id, :faraday_block

    def initialize(base_url: nil, account_secret_key: nil, shop_id: nil, faraday_block: nil)
      @base_url = base_url
      @account_secret_key = account_secret_key
      @shop_id = shop_id
      @faraday_block = faraday_block
    end
  end
end
