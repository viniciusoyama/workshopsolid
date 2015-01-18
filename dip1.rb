class Copier
  def copy
    reader = Keyboard.new
    writer = Display.new
    reader.get_input do |input| 
      writer.write(input)
    end
  end
end

# Now I want to use the copier module in the same app display in a 'sms'. Each char will be sent to sms.. Simple..

# The protocol is defined by details. not by the high level logic that is the copier 

class Copier
  def initialize(reader, writter)
    @reader = reader
    @writter = writter
  end

  def copy
    @reader.get_input do |input| 
      @writter.write(input)
    end
  end
end

# Now I can pass any objet that implements #get_input and #write 
# I can EXTEND the behavior without MODIFYING the existing code
