# frozen_string_literal: true

require_relative 'config'

# class Helper
class Helper
  def self.build_api_url(ip_address)
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
end
