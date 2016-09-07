require 'minitest/autorun'
require 'minitest/pride'
require './lib/repl'


class ReplTest < Minitest::Test

  def test_i_can_split_input_into_an_array_of_strings
    a = Repl.new


    assert_equal ["find", "first_name", "anthony"], a.split_input("find first_name anthony")
  end

  def test_the_load_file_can_load_csv
    a = repl.new
    a.run

    assert_equal "find", a.demand
  end
end
