# frozen_string_literal: true

require 'http'
require_relative '../activity'

module Strava
  class APIRequest
    attr_reader :token

    def initialize(token)
      @token = token
    end

    # TODO: use more robust response handling
    def fetch_activities
      results =
        HTTP.auth("Bearer #{token}")
            .get('https://www.strava.com/api/v3/athlete/activities?per_page=200')
      raise results.status.reason unless results.status.success?

      results.parse.map { |activity| Activity.new(activity) }
    end
  end
end
