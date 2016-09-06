require 'minitest/autorun'
require 'minitest/pride'
require './lib/help.rb'

class HelpTest < Minitest::Test

  def test_prints_general_information


    assert_match /The available commands are:/, Help.general
  end

  def test_prints_desciption_for_count_command

    assert_equal "Output how many recoreds are in the current queue", Help.count
  end

  def test_prints_desciption_for_clear_command

    assert_equal "Empty the queue", Help.clear
  end

  def test_prints_desciption_for_print_command

    assert_match /Print out tab-delimited/, Help.print
  end

  def test_prints_desciption_for_find_command

    assert_match /Load the queue/, Help.find
  end

  def test_prints_desciption_for_load_command

    assert_match /Erase any loaded data and parse/, Help.load
  end

  def test_prints_desciption_for_save_to_command

    assert_match /Export the current queue/, Help.save_to
  end

  def test_prints_desciption_for_print_by_command

    assert_match /Print the data table sorted/, Help.print_by
  end
end
