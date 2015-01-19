class Shape
  attr_accessor :id # fills automagicallly
end

class Rectangle < Shape
  attr_accessor :id # fills automagicallly
  attr_accessor :height, :width
end

# Bind methods to user actions and rerender the view
class UIInteractor
  # increases shapes height by 1 on every click and prints the perimeter
  def click_listener
    @shapes.each do |shape| 
      shape.height += 1 
      @perimeter_by_shape_id[shape.id] += 1 # WoWW!
    end
  end
end
