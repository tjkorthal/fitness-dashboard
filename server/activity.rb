# An activity an athlete completed
class Activity
  MILES_PER_METER = 0.00062137
  SECONDS_PER_HOUR = 3600
  MINUTES_PER_HOUR = 60

  attr_reader :type, :distance, :elapsed_time, :moving_time
  def initialize(params)
    @type = params['type']
    @distance = params['distance']
    @elapsed_time = params['elapsed_time']
    @moving_time = params['moving_time']
    @start_time = params['start_date_local']
  end

  def distance_in_miles
    distance * MILES_PER_METER
  end

  def elapsed_time_in_hours
    elapsed_time.to_f / SECONDS_PER_HOUR
  end

  def moving_time_in_hours
    moving_time.to_f / SECONDS_PER_HOUR
  end

  def start_time
    @_start_time ||= DateTime.parse(@start_time)
  end

  def as_json(_opts = {})
    {
      type: type,
      distance: format('%.2f mi', distance_in_miles),
      elapsed_time: format('%.2f hr', elapsed_time_in_hours),
      moving_time: format('%.2f hr', moving_time_in_hours),
      start_time: start_time
    }
  end
end
