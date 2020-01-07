class Jugador {
  PVector posicion, velocidad;
  PImage base;
  int ancho, alto;
  
  Jugador() {
    ancho = 70;
    alto = 10;
    
    base = loadImage("base.png"); //Se carga la imagen de la base del jugador prediseñada
    
    posicion = new PVector(width/2, height - 50); //Su posicion inicial estará centrada horizontalmente
    velocidad = new PVector(3, 0); //Su velocidad en x será de 3, y en y será de 0, ya que solo se puede mover a los lados
  }
  
  //Metodo para moverse a los lados
  void mover() {
    //Si alguna tecla es presionada, pasará lo de adentro
    if(keyPressed) {
      //Si se presiona la tecla LEFT, la base se moverá a la izquierda
      if(keyCode == LEFT) {
        posicion.x -= velocidad.x;
      } 
      //Si se presiona la tecla RIGHT, la base se moverá a la derecha
      else if(keyCode == RIGHT) {
        posicion.x += velocidad.x;
      }
    }
    
    /*Se crea una restriccion para la posicion en x.
    Solo puede tener valores entre el ancho/2 y el width - ancho/2
    de esta manera no se saldrá de la pantalla */
    posicion.x = constrain(posicion.x, ancho/2, width - ancho/2);
  }
  
  //Se dibuja la base del jugador
  void mostrar() {
    imageMode(CENTER);
    image(base, posicion.x, posicion.y);
  }
  
  PVector getPosicion() {
    return posicion;
  }
  
  int getAncho() {
    return ancho;
  }
  
  int getAlto() {
    return alto;
  }
}
