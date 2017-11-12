module Spree
  module ActiveShipping
    module RajaOngkir
      cattr_reader :name
      @@name = 'RajaOngkir'

      HOST = 'https://api.rajaongkir.com/starter/cost'

      def requirements
        [:api_key]
      end

      def find_rates(origin, destination, options = {})
        url = URI(HOST)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Post.new(url)
        request["key"] = options[:api_key]
        request["content-type"] = 'application/x-www-form-urlencoded'
        request.body = "origin=#{origin}&destination=#{destination}&destinationType=#{options[:subdistrict]}&weight=#{options[:weight]}&courier=#{options[:courier]}"

        response = http.request(request)

        RateResponse.new(true, 'success', {}, response.read_body)
      end

    end # end of module RajaOngkir
  end
end