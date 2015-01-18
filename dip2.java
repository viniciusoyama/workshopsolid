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
  
//
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

// Bem mais claro.. suponha que tenho um modulo de copiadora. Nesse modulo que eu definiria as interfaces e poderia compilar ele.
// Qualquer outro app que utilizar só precisa implementar a interface
// Low level depending on abstractions
