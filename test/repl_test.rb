require './lib/repl'
require_relative '../test/test_helper'

class ReplTest < Minitest::Test

  def test_repl_can_run

    i = Repl.new
    i.run
  end
end
