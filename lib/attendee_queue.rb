require 'csv'
require_relative 'attendee'
require_relative 'help'
require 'open-uri'
require 'json'

class AttendeeQueue
  HEADER = ["LAST NAME","FIRST NAME","EMAIL","ZIPCODE","CITY","STATE","ADDRESS","PHONE","DISTRICT"]

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
    @queue.length
  end

  def print_queue
     @queue
  end

  def set_district
    @queue.each do |record|
      record.district = get_districts(record.zipcode)
    end
  end

  def get_districts(zipcode)
    url = "http://congress.api.sunlightfoundation.com/districts/locate?zip=#{zipcode}&apikey=7f37e6069038458d9d3cb6001c8d560e"
    data = JSON.parse(open(url).read)
    data_parsed = data.values[0]
    district_and_state = data_parsed.map do |record|
      "#{record["state"]}: #{record["district"]}"
    end
    data_return = district_and_state.join(" / ")
    return data_return
  end

  def prints(queue = @queue)
    header = "\nLAST NAME".ljust(15) + "FIRST NAME".ljust(15) + "EMAIL".ljust(45) + "ZIPCODE".ljust(15) + "CITY".ljust(30) + "STATE".ljust(10) + "ADDRESS".ljust(40) \
    + "PHONE".ljust(15) + "DISTRICT"
    puts header
    queue.each do |data|
      puts
      a = "#{data.send(:last_name).ljust(15)}" + "#{data.send(:first_name).ljust(15)}" + "#{data.send(:email_address).ljust(45)}" \
     + "#{data.send(:zipcode).ljust(15)}" + "#{data.send(:city).ljust(30)}" + "#{data.send(:state).ljust(10)}" + "#{data.send(:street).ljust(40)}" + "#{data.send(:homephone).ljust(15)}" \
     + "#{data.send(:district)}\n"
      print a
    end
  end

  def print_by(attribute)
    @sorted_queue = @queue.sort_by { |att| att.send(attribute) }
    prints(@sorted_queue)
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
