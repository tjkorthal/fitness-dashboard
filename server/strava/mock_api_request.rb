# frozen_string_literal: true

require_relative '../activity'

module Strava
  # behaves like an APIRequest, but returns stubbed data
  class MockAPIRequest
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def fetch_activities
      path = File.expand_path('./test_data.json')
      content = File.new(path).read
      activities = JSON.parse(content)
      activities.map { |activity| Activity.new(activity) }
    end
  end
end
