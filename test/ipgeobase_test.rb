# frozen_string_literal: true

require 'addressable/template'
require 'json'
require 'yaml'

require_relative 'test_helper'
require_relative '../lib/ipgeobase'
require_relative '../helpers'

class IpgeobaseTest < Minitest::Test
  include Ipgeobase

  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_lookup
    test_data = YAML.load_file("#{__dir__}/fixtures/data.yml")
    expected_query_hash, fake_response, test_ip = test_data.values_at(
      'expected_query_hash', 'fake_response', 'test_ip'
    )

    fake_response_json = JSON.generate(fake_response)
    api_uri = build_api_url(test_ip)

    stub_request(:any, api_uri)
      .with(query: expected_query_hash)
      .to_return(body: fake_response_json)

    assert_equal fake_response, Ipgeobase.lookup(test_ip).to_hash
  end
end
