# frozen_string_literal: true

require "contactpay/config"
require "contactpay/version"
require "contactpay/account"
require "contactpay/balance"
require "contactpay/transaction"
require "contactpay/deposit"
require "contactpay/withdraw"

# Head module
module Contactpay
  class << self
    attr_accessor :config
  end

  def self.config
    @config ||= Config.new
  end

  def self.reset
    @config = Config.new
  end

  def self.configure
    yield(config)
  end
end