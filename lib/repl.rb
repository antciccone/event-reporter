require './lib/attendee_queue'
require_relative 'attendee_queue'
require_relative 'help'
require_relative 'file_generation'
require 'pry'

class Repl
    attr_reader :attendee_queue, :demand, :criteria, :attribute, :command
  def initialize
    @attendee_queue = AttendeeQueue.new
    @command = ""
    @demand  = ""
    @criteria = ""
    @attribute = ""
    @fix = ""
  end

  def run
    puts "Welcome to Event Reporter"
    input = ""
    until input == "quit"
      puts "Please enter a command:"
      input = gets.chomp
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
    combine_last_index
    attendee_queue.clear if @attendee_queue.count != 0
    @attendee_queue.find_by(criteria, @fix)
  end

  def combine_last_index
    @fix = command[2..-1].join(" ")
  end

  def queue
    combine_by_and_combine_to
    case @new_criteria
    when "count"
      puts @attendee_queue.count
    when "clear"       then @attendee_queue.clear
      puts "queue is cleared"
    when "print"       then @attendee_queue.prints
    when "print by"    then @attendee_queue.print_by(@new_attribute)
    when "save to"     then @attendee_queue.save(@new_attribute)
    when "district"    then @attendee_queue.set_district
    binding.pry
    when "export html" then FileGeneration.export_html(@new_attribute, @attendee_queue.queue)
    end
  end

  def combine_by_and_combine_to
    if attribute == 'by' || attribute == 'to' || attribute == 'html'
      @new_criteria = command[1..2].join(" ")
      @new_attribute = command[3]
    else
      @new_criteria = criteria
    end
  end

  def help
    criteria.nil? ? Help.send("general") : Help.send(criteria && attribute)
    binding.pry
  end

  def load_finder
    if criteria != nil
      load_file(criteria)
    else
      load_file
    end
    puts "File was loaded!"
  end

  def load_file(file_path = "event_attendees.csv")
    @attendee_queue.load_file(file_path)
  end
end
