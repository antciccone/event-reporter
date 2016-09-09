require './lib/attendee'
require 'pry'
require_relative '../test/test_helper'

class AttendeeTest < Minitest::Test

  def data
    {
      id: 1,
      regdate:        "September 4, 2016",
      first_name:     "ANTHONY",
      last_name:      "Ciccone",
      email_address:  "aciccone@yahoo.com",
      homephone:      "973-525-7892",
      street:         "42 brookside drive",
      city:           "SPaRta",
      state:          "NJ",
      zipcode:        "7871",
      district:       "nil"
    }
  end

  def test_can_clean_input_data_into_a_proper_format
    person = Attendee.new(data)

    assert_equal 1, person.id
    assert_equal "September 4, 2016", person.regdate
    assert_equal "anthony", person.first_name
    assert_equal "ciccone", person.last_name
    assert_equal "aciccone@yahoo.com", person.email_address
    assert_equal "9735257892", person.homephone
    assert_equal "42 brookside drive", person.street
    assert_equal "sparta", person.city
    assert_equal "nj", person.state
    assert_equal "07871", person.zipcode
  end

  def test_it_can_clean_wrongly_formatted_zipcode
    person = Attendee.new(data)

    proper_zipcode = "10010"
    zipcode_is_to_short = "23"
    zipcode_is_to_long = "2834112"

    assert_equal "00023", person.clean_zipcode(zipcode_is_to_short)
    assert_equal "28341", person.clean_zipcode(zipcode_is_to_long)
    assert_equal "10010", person.clean_zipcode(proper_zipcode)
    assert_equal "00000", person.clean_zipcode(nil)
    assert_equal "00000", person.clean_zipcode("")
  end

  def test_is_can_clean_wrongly_formatted_homephome_numbers
    person = Attendee.new(data)

    proper_home_phone = "9737268512"
    home_home_with_dashes = "973-525-7892"
    home_phone_that_starts_with_one = "19735257892"


    assert_equal "9737268512", person.clean_homephone(proper_home_phone)
    assert_equal "9735257892", person.clean_homephone(home_home_with_dashes)
    assert_equal "9735257892", person.clean_homephone(home_phone_that_starts_with_one)
    assert_equal "0000000000", person.clean_homephone(nil)
    assert_equal "0000000000", person.clean_homephone("")
  end

  def test_it_can_clean_wrongly_formatted_state
    person = Attendee.new(data)

    uppercase_state = "NY"
    proper_state = "ny"

    assert_equal "ny", person.clean_state(uppercase_state)
    assert_equal "ny", person.clean_state(proper_state)
    assert_equal "xx", person.clean_state(nil)
    assert_equal "xx", person.clean_state("")
  end

  def test_it_can_clean_wrongly_formatted_city
    person = Attendee.new(data)

    proper_city = "salt lake city"
    upcase_city = "Salt Lake City"

    assert_equal "salt lake city", person.clean_city(proper_city)
    assert_equal "salt lake city", person.clean_city(upcase_city)

  end

  def test_can_clean_wrongly_formatted_last_name
    person = Attendee.new(data)

    proper_name = "chen"
    wrong_format = "ChEn"

    assert_equal "chen", person.clean_last_name(proper_name)
    assert_equal "chen", person.clean_last_name(wrong_format)
  end

  def test_can_clean_wrongly_formatted_last_name
    person = Attendee.new(data)

    proper_name = "melissa"
    wrong_format = "MelissA"

    assert_equal "melissa", person.clean_last_name(proper_name)
    assert_equal "melissa", person.clean_last_name(wrong_format)
  end
end
