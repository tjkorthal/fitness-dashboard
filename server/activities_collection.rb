# frozen_string_literal: true

# Collects and holds athlete activities
class ActivitiesCollection
  include Enumerable

  attr_reader :activities

  def initialize(activities = [])
    @activities = activities
  end

  def each
    activities.map { |activity| yield activity }
  end

  def since(date)
    parsed_date = DateTime.parse(date)
    filtered_activities = activities.select { |activity| activity.start_time > parsed_date }
    ActivitiesCollection.new(filtered_activities)
  end

  # eg ActivitiesCollection.new.since('07-04-2021').stat_total_by_type(:distance_in_miles)
  def stat_total_by_type(stat_attribute)
    group_by(&:type).map do |type, activity_list|
      total = activity_list.map(&stat_attribute.to_sym).reduce(:+).round(2)
      "#{type}: #{total}"
    end
  end

  def as_json(_opts = {})
    each(&:as_json)
  end
end
