require 'pry'


module Help
  def self.general
    puts "The available commands are: [load <filename>] [queue count] [queue clear] [queue print] [queue print by <attribute>] [queue save to <filename.csv>] [find <attribute> <criteria>]  Type  the command name to learn more about each command"
  end

  def self.count
    puts "Output how many recoreds are in the current queue"
  end

  def self.clear
    puts "Empty the queue"
  end

  def self.print
   puts "Print out tab-delimited data table with a header row"
  end

  def self.find
    puts "Load the queue with all records matching the criteria for the given attribute"
  end

  def self.load
    puts "Erase any loaded data and parse the specified file. If no filename is given, the default filename is event_attendees.csv"
  end

  def self.save_to
    puts "Export the current queue to the specified filename as a CSV"
  end

  def self.print_by
    puts "Print the data table sorted by the specified attribute like state"
  end
end
