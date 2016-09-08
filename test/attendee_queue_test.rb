require './lib/attendee_queue'
require 'csv'
require_relative '../test/test_helper'

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
    file.find_by("first_name","John")

    assert_equal file.queue[0].first_name, "john"
    assert_equal 63, file.count
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

  def test_can_clear_the_queue
    file = AttendeeQueue.new
    file.load_file("event_attendees.csv")
    file.find_by("zipcode","92037")

    assert_equal 3, file.count

    file.clear
    assert_equal [], file.clear
  end

  def test_can_just_print_the_header
    file = AttendeeQueue.new
    file.find_by("first_name","anthony")
    assert_equal "LAST NAME FIRST NAME EMAIL ZIPECODE CITY STATE ADDRESS PHONE DISTRICT", file.prints
  end

  def test_can_print_queue

    file = AttendeeQueue.new
    file.load_file("event_attendees.csv")
    file.find_by("first_name" , "john")  #how do assert equal?

  end

  def test_can_save_queue_to_anotherfile

    file = AttendeeQueue.new
    file.load_file("event_attendees.csv")  #how to asset equal?
    file.find_by("first_name" , "john")
    file.save("john search.csv")
  end

  def test_get_districts_pulls_district_from_zipcode
    file = AttendeeQueue.new
    zipcode = "01039"


    assert_equal "MA: 1 / MA: 2", file.get_districts(zipcode)
  end


end
