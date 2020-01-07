class Escenario {
  ArrayList<PVector> blocks = new ArrayList<PVector>();
  ArrayList<Integer> colorBlock = new ArrayList<Integer>();
  
  int ancho, alto, col, fil, dif;
  color[] colores = new color[5];
  
  //Nuestro constructor tendra como parametro el nivel actual del juego
  Escenario(int nivel) {
    //De esta manera el grado de dificultad sube
    col = 5 * nivel; //El numero de columnas será multiplicado por el nivel actual
    fil = 5 * nivel; //El numero de filas será multiplicado por el nivel actual
    
    dif = 50; //El espaciado entre los bloques y las paredes
    
    ancho = (width - dif * 2)/col; //Ancho de cada bloque
    alto = 20; //Alto de cada bloque
    
    colores[0] = color(#FF0D0D); //Color rojo
    colores[1] = color(#FAFF0D); //Color amarillo
    colores[2] = color(#0DA0FF); //Color azul
    colores[3] = color(#FF0DD3); //Color magenta
    colores[4] = color(#0DFF3B); //Color verde
  }
  
  //Metodo para crear bloques
  void crearEscenario() {
    //Los bloques se colocaran por filas
    for(int i = 0; i < fil; i++) {
      for(int j = dif; j <= width - dif - ancho; j+= ancho) {
        blocks.add(new PVector(j, (alto*i) + dif));
      }
    }
    //Se ejecuta el metodo para asignar los colores
    asignarColor();
  }

  //Metodo para asignar color a cada bloque
  void asignarColor() {
    int aux = 0; //Variable auxiliar
    for(int i = 0; i < fil; i++) {
      for(int j = 0; j < col; j++) {
        //A cada fila se le asignará un color
        colorBlock.add(colores[aux]);
      }
      aux++; //El color cambia para la siguiente fila
      
      /*Debido a que solo hay 4 colores y puede haber más de 4
      filas, cada vez que se llegue al ultimo color, se volvera 
      a empezar por el primer color, teniendo asi un patron repetitivo*/
      
      if(aux > 4) {
        aux = 0;
      }
    }
  }
  
  //Metodo para dibujar los bloques en la pantalla
  void mostrar() {
    stroke(0);
    strokeWeight(2);
    for(int i = 0; i < blocks.size(); i++) {
      PVector block = blocks.get(i);
      int colorBlock = this.colorBlock.get(i);
      
      fill(colorBlock); //Se le asgina a cada bloque su color correspondiente
      rect(block.x, block.y, ancho, alto);
    }
  }
  
  int getAncho() {
    return ancho;
  }
  
  int getAlto() {
    return alto;
  }
  
  ArrayList<PVector> getBlocks() {
    return blocks;
  }
  
  ArrayList<Integer> getColores() {
    return colorBlock;
  }
  
  int getNumBlocks() {
    return blocks.size();
  } 
} 
