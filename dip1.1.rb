# Now I want to use the copier module in the same app
# Each char will be sent to a speaker

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
