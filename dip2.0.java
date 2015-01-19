// SEM DIP
public class Copier {
  public copy() {
    Char c;
    Keyboard reader = new Keyboard()
    Display writter = new Display()
    while(c = reader.getInput()) {
      writter.write(c);
    }
  }
}
  
// COM DIP
public class Copier {
  public Copier(IReader reader, IWriter writer) {
    this.reader = reader;
    this.writer = writer;
  }

  public copy() {
    Char c;
    
    while(c = this.reader.getInput()) {
      this.writter.write(c);
    }
  }
}

// Low level depending on abstractions
