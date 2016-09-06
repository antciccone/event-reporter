require 'minitest/autorun'
require 'minitest/pride'
require './lib/attendee_queue'
require 'csv'

class AttendeeQueuetest < Minitest::Test

  def test_can_open_a_file
    file = AttendeeQueue.new

    file.load_file("event_attendees.csv")
    refute file.attendee_info[0].nil?
  end

  def test_can_find_by_first_name
    file = AttendeeQueue.new
    file.load_file("event_attendees.csv")
    file.find_by("first_name", "sara")

    assert_equal file.queue[0].first_name, "sara"
  end

  def test_can_find_by_first_name_and_count
    file = AttendeeQueue.new
    file.load_file("event_attendees.csv")
    file.find_by("first_name","allison")

    assert_equal file.queue[0].first_name, "allison"
    assert_equal 16, file.count
  end

  def test_can_find_by_last_name_and_count
    file = AttendeeQueue.new

    file.load_file("event_attendees.csv")
    file.find_by("last_name","Chen")

    assert_equal file.queue[0].last_name, "chen"
    assert_equal 3, file.count
  end

  def test_can_find_by_state_and_count
    file = AttendeeQueue.new

    file.load_file("event_attendees.csv")
    file.find_by("state","NJ")

    assert_equal file.queue[0].state, "nj"
    assert_equal 103, file.count
  end

  def test_can_find_by_zipcode
    file = AttendeeQueue.new
    file.load_file("event_attendees.csv")
    file.find_by("zipcode","92037")

    assert_equal file.queue[0].zipcode, "92037"
    assert_equal 3, file.count
  end
end
