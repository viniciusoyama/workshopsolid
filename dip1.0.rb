# Alto coupling
class Copier
  def copy
    reader = Keyboard.new
    writer = Display.new
    reader.get_input do |input| 
      writer.write(input)
    end
  end
end

# The protocol is defined by details. Not by the high level logic that is the copier 
