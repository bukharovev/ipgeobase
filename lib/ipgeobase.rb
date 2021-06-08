# frozen_string_literal: true

require 'net/http'
require 'json'
require 'addressable'
require_relative 'ipgeobase/version'
require_relative '../helpers'

# module for lookup ip metadata
module Ipgeobase
  class Error < StandardError; end

  # class to return ip_metadata object
  class IpMeta
    attr_reader :ip_meta_hash

    def initialize(hash)
      @ip_meta_hash = hash

      hash.each do |(key, value)|
        define_singleton_method key do
          value
        end
      end
    end

    def to_hash
      @ip_meta_hash
    end
  end

  def self.lookup(ip_address)
    api_uri = build_api_url(ip_address)

    response = Net::HTTP.get(api_uri)
    response = 'null' if response.empty?

    ip_meta_hash = JSON.parse(response)

    IpMeta.new ip_meta_hash
  end
end
