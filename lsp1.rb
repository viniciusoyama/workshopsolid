class Rectangle
  attr_accessor :id # fills automagicallly
end

class Rectangle < Shape
  attr_accessor :height, :width
end

class Square < Rectangle
  def width=(value)
    super
    self.height=value
  end

  def height=(value)
    super
    self.width=value
  end
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
