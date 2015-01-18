class User
  def to_s
    HTMLUserPrinter.new(user).print
  end
end

# With DIP

class User
  def to_s(user_printer)
    user_printer.print
  end
end

