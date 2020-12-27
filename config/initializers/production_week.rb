# frozen_string_literal: true
require 'concurrent'
require 'active_support/core_ext/time/calculations'
require 'active_support/core_ext/time/conversions'
require 'active_support/core_ext/numeric/time'

module Extensions # no-doc
  # Syntax:
  #   today = Time.current
  #   today.production_beginning_of_week => Object<Time>
  #   today.production_end_of_week => Object<Time>
  #
  # Usage:
  #
  #   FIRST! initialise on app bootup or controller#around_action:
  #
  #     # defaults to 0 o'clock Monday morning (or Midnight Sunday)
  #     Time.production_hour_of_day = 14 # default is 0
  #     Time.production_day_of_week = 4  # default is 0
  #
  #   Then:
  #     today = Time.current (or in an appropriate timezone)
  #     today.production_end_of_week.strftime("%Y-%m-%d") => "2019-08-01"
  #

  module ProductionWeek
    # Returns a <Time> object specifying the date and time of the
    # start of your production week.
    #
    def production_beginning_of_week
      day_offset = Time.production_day_of_week.value - self.beginning_of_week.wday
      prod_bow = self.beginning_of_week + day_offset.days + Time.production_hour_of_day.value.hours

      if self < prod_bow ||
        (today_is_bow?(self) &&
          !past_production_time?(self))
        prod_bow -= 7.days
      end

      prod_bow
    end
    alias :pbow :production_beginning_of_week

    # Returns a <Time> object specifying the date and time of the
    # end of your production week relative to the current system
    # date, time and zone
    #
    def production_end_of_week
      production_beginning_of_week + 7.days - 1
    end
    alias :peow :production_end_of_week

    private

    def today_is_bow?(current_day)
      current_day.wday == Time.production_day_of_week.value
    end

    def past_production_time?(current_day)
      curr = current_day.sec + current_day.min.minutes + current_day.hour.hours
      prod = Time.production_hour_of_day.value.hours
      curr >= prod
    end

    # When rails ActiveSupport not installed
    # ----------
    # def beginning_of_week
    #   Time.new(self.year, self.month, self.day + (1 - self.wday), 0, 0)
    # end
  end
end

class Time
  include Extensions::ProductionWeek

  class << self
    def production_hour_of_day
      @production_hour_of_day ||= Concurrent::ThreadLocalVar.new(0)
    end
    def production_hour_of_day=(value)
      @production_hour_of_day = Concurrent::ThreadLocalVar.new(value)
    end

    def production_day_of_week
      @production_day_of_week ||= Concurrent::ThreadLocalVar.new(0)
    end
    def production_day_of_week=(value)
      @production_day_of_week = Concurrent::ThreadLocalVar.new(value)
    end

    def current_eow
      current.production_end_of_week.to_date
    end

    def previous_eow
      (current - 7.days).production_end_of_week.to_date
    end
  end
end

Time.production_hour_of_day = 14
Time.production_day_of_week = 4
