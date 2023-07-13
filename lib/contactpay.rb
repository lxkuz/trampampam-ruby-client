# frozen_string_literal: true

require "contactpay/config"
require "contactpay/version"
require "contactpay/withdraw"
require "contactpay/invoice"

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