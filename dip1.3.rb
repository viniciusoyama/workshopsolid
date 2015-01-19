class Copier
  def initialize(reader, writter)
    @reader = reader
    @writter = writter
  end

  def copy
    if @reader.is_a?(Keyboard)
      @reader.get_char do |input| 
        @writter.write(input)
      end
    else
      @reader.get_input do |input| 
        @writter.write(input)
      end
    end
  end
end

class Keyboard 
  def get_char
    # ...
  end
end

class Touch 
  def get_input
    # ...
  end
end

