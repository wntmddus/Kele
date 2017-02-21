require "httparty"
require "json"


class Kele
  include HTTParty

  def initialize(email, password)
    response = self.class.post(base_api_endpoint("sessions"), body: { "email": email, "password": password })
    @auth_token = response["auth_token"]
  end

  private

  def base_api_endpoint(end_point)
    "https://www.bloc.io/api/v1/#{end_point}"
  end
end
