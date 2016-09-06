require 'csv'
require- 'attendee'
require_relative 'help'

class AttendeeQueue

  attr_accessor :attendee_info, :queue
  def initialize
    @attendee_info = []
    @queue = []
  end

  def load_file(file_name)
    CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
      @attendee_info << Attendee.new(row)
    end
  end

  def find_by(attribute, criteria)
    @queue = @attendee_info.select { |data| data.send(attribute) == criteria.downcase }
  end

  def clear
    @queue.clear
  end

  def count

  end
end

puts a = AttendeeQueue.new
