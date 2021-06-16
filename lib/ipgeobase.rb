# frozen_string_literal: true

require 'net/http'
require 'json'
require 'addressable'
require 'ostruct'
require_relative 'ipgeobase/version'
require_relative 'helpers'

# module for lookup ip metadata
module Ipgeobase
  class Error < StandardError; end

  def self.lookup(ip_address)
    api_uri = Helper.build_api_url(ip_address)

    response = Net::HTTP.get(api_uri)
    return if response.empty?

    ip_meta_hash = JSON.parse(response)

    OpenStruct.new ip_meta_hash
  end
end
