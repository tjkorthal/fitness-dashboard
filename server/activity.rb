# An activity an athlete completed
class Activity
  MILES_PER_METER = 0.00062137
  SECONDS_PER_HOUR = 3600
  SECONDS_PER_MINUTE = 60

  attr_reader :type, :distance, :elapsed_time, :moving_time
  def initialize(params)
    @type = params['type']
    @distance = params['distance']
    @elapsed_time = params['elapsed_time'].to_f
    @moving_time = params['moving_time'].to_f
    @start_time = params['start_date_local']
  end

  def distance_in_miles
    distance * MILES_PER_METER
  end

  def elapsed_time_in_hours
    elapsed_time / SECONDS_PER_HOUR
  end

  def elapsed_time_to_human
    time_to_human(elapsed_time / SECONDS_PER_MINUTE)
  end

  def moving_time_in_hours
    moving_time / SECONDS_PER_HOUR
  end

  def moving_time_to_human
    time_to_human(moving_time / SECONDS_PER_MINUTE)
  end

  def start_time
    @_start_time ||= DateTime.parse(@start_time)
  end

  def as_json(_opts = {})
    {
      type: type,
      distance: format('%.2f mi', distance_in_miles),
      elapsed_time_in_hours: elapsed_time_in_hours,
      elapsed_time_to_human: elapsed_time_to_human,
      moving_time_in_hours: moving_time_in_hours,
      moving_time_to_human: moving_time_to_human,
      start_time: start_time
    }
  end

  private

  def time_to_human(minutes)
    hours = (minutes / 60).round(half: :down)
    minutes = (minutes - hours * 60)
    return format('%.0f hr', hours) if minutes <= 0
    return format('%.0f min', minutes) if hours.zero?

    format('%.0f hr %.0f min', hours, minutes)
  end
end
