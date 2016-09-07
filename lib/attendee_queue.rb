require 'csv'
require_relative 'attendee'
require_relative 'help'


require 'sunlight/congress'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

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
    @queue.count 
  end

  def print_queue
     @queue
  end

  # def District
  #   if @queue.count < 10
  #     queue.each do |row|
  #       legislators_by_zipcode(row.zipcode)
  #     end
  #   end
  # end
  #
  # def legislators_by_zipcode(zipcode)
  #   legislators =  Sunlight::Congress::Legislator.by_zipcode(zipcode)
  #
  # end

  def prints
    header = "LAST NAME FIRST NAME EMAIL ZIPECODE CITY STATE ADDRESS PHONE DISTRICT"
  end

  def print_by
    header = "\nLAST NAME".ljust(15) + "FIRST NAME".ljust(15) + "EMAIL".ljust(45) + "ZIPCODE".ljust(15) + "CITY".ljust(30) + "STATE".ljust(10) + "ADDRESS".ljust(40) \
    + "PHONE".ljust(15) + "DISTRICT"
    puts header
    @queue.each do |data|
      puts
      a = "#{data.send(:last_name).ljust(15)}" + "#{data.send(:first_name).ljust(15)}" + "#{data.send(:email_address).ljust(45)}" \
     + "#{data.send(:zipcode).ljust(15)}" + "#{data.send(:city).ljust(30)}" + "#{data.send(:state).ljust(10)}" + "#{data.send(:street).ljust(40)}" + "#{data.send(:homephone).ljust(15)}"

      print a
    end
  end


  def save(to_file="queue_save.csv")
      CSV.open(to_file, "w") do |file|
        file << ['RegDate','first_Name','last_Name','Email_Address','HomePhone','Street','City','State','Zipcode']
        queue.each do |entry|
          file << [entry.regdate, entry.first_name, entry.last_name, entry.email_address, entry.homephone, entry.street, entry.city, entry.state, entry.zipcode]
      end
    end
  end
end
