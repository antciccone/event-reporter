require 'pry'

class Attendee
  attr_reader :first_name,
              :last_name,
              :email_address,
              :homephone,
              :street,
              :city,
              :state,
              :zipcode,
              :id,
              :regdate,
              :data

  def initialize(data)
    @first_name     = clean_first_name(data[:first_name])
    @last_name      = clean_last_name(data[:last_name])
    @email_address  = data[:email_address]
    @homephone      = clean_homephone(data[:homephone])
    @street         = (data[:street])
    @city           = clean_city(data[:city])
    @state          = clean_state(data[:state])
    @zipcode        = clean_zipcode(data[:zipcode])
    @id             = data[:id]
    @regdate        = data[:regdate]
  end

  def clean_first_name(first_name)
    first_name.downcase if first_name != nil
  end

  def clean_last_name(last_name)
    last_name.downcase if last_name != nil
  end

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5, "0")[0..4]
  end

  def clean_state(state)
    if state == "" || state.nil?
      state = "xx"
    else
      state = state.downcase
    end
  end

  def clean_city(city)
    city.split.map {|word| word.capitalize}.join(' ') if city != nil
  end

  def clean_homephone(homephone)
  homephone.to_s.gsub(/[^0-9]/, "").ljust(10,"0")[-10..-1]
  end
end
