require './lib/attendee_queue'
require_relative 'attendee_queue'
require_relative 'help'
require 'pry'

class Repl
    attr_reader :attendee_queue, :demand, :criteria, :attribute, :command
  def initialize
    @attendee_queue = AttendeeQueue.new
    @command = ""
    @demand  = ""
    @criteria = ""
    @attribute = ""
  end

  def run
    input = gets.chomp
    until input == "quit"
      @command = split_input(input)
      assign_input_instructions
      first_demand
    end
  end

  def split_input(input)
    @command = input.split
  end

  def assign_input_instructions
   @demand = command[0]
   @criteria = command[1]
   @attribute = command[2]
  end

  def first_demand
    case demand
      when "load" then  load_finder
      when "find"  then  find
      when "queue" then queue
      when "help"  then help
    end
  end

  def find
    #if queue is not empty i need to clear it
    case criteria
    when "first_name" then @attendee_queue.find_by("first_name", attribute)
    when "last_name"  then @attribute_queue.find_by("last_name", attribute)
    when "city "    then @attribute_queue.find_by("city", attribute)
    when "state"    then @attribute_queue.find_by("state", attribute)
    end
  end

  def queue
    case criteria
    when "count"    then  @attribute_queue.count
    when "clear"    then
    when "prints"   then
    when "pint_by"  then
    when "save to"  then
    end
  end

  def help

  end


  def load_finder
    if criteria != nil
      load_file(criteria)
    else
      load_file
    end
  end

  def load_file(file_path = "event_attendees.csv")
    @attendee_queue.load_file(file_path)
  end
end

i = Repl.new
i.run
