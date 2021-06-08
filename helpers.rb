# frozen_string_literal: true

require_relative 'config'

def build_api_url(ip_address)
  template = Addressable::Template.new("#{API_URL}/{path}/{params}{?query*}")
  template.expand(
    {
      path: 'json',
      params: ip_address,
      query: {
        fields: 'city,country,countryCode,lat,lon'
      }
    }
  )
end
