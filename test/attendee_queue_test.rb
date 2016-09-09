require './lib/attendee_queue'
require 'csv'
require_relative '../test/test_helper'

class AttendeeQueuetest < Minitest::Test

  def test_that_attendee_queue_is_a_class
    file = AttendeeQueue.new
    assert_equal AttendeeQueue, file.class
  end

  def test_load_file_can_load_a_file
    file = AttendeeQueue.new

    file.load_file("event_attendees.csv")
    refute file.attendee_info[0].nil?
  end

  def test_can_find_by_first_name_within_loaded_file
    file = AttendeeQueue.new
    file.load_file("event_attendees.csv")
    file.find_by("first_name", "Sara")

    assert_equal file.queue[0].first_name, "sara"
    assert_equal file.queue[1].first_name, "sara"
  end

  def test_can_find_by_attribute_and_count
    file = AttendeeQueue.new
    file.load_file("event_attendees.csv")

    attribute = ("first_name")
    file.find_by(attribute,"John")

    assert_equal file.queue[0].first_name, "john"
    assert_equal 63, file.count
  end

  def test_can_find_by_different_attributes_and_count
    file = AttendeeQueue.new
    file.load_file("event_attendees.csv")

    attribute = ("last_name")
    file.find_by(attribute, "Chen")

    assert_equal file.queue[0].last_name, "chen"
    assert_equal 3, file.count
  end

  def test_can_find_by_different_attributes_and_count
    file = AttendeeQueue.new
    file.load_file("event_attendees.csv")

    attribute = "state"
    file.find_by(attribute,"NJ")

    assert_equal file.queue[0].state, "nj"
    assert_equal 103, file.count
  end

  def test_can_find_by_different_attributes_and_count
    file = AttendeeQueue.new
    file.load_file("event_attendees.csv")
    file.find_by("zipcode","92037")

    assert_equal file.queue[0].zipcode, "92037"
    assert_equal 3, file.count
  end

  def test_can_clear_the_queue
    file = AttendeeQueue.new
    file.load_file("event_attendees.csv")
    file.find_by("zipcode","92037")

    assert_equal 3, file.count

    file.clear
    assert_equal [], file.clear
  end

  def test_get_districts_pulls_district_from_zipcode
    file = AttendeeQueue.new
    zipcode = "01039"

    assert_equal "MA: 1 / MA: 2", file.get_districts(zipcode)
  end
end
