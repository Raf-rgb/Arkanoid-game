class Pelota {
  PVector posicion, velocidad;
  int tamano, puntos;
  
  //Nuestro constructor tendrá como parametro la posicion de la base del jugador
  Pelota(PVector posicion_) {
    tamano = 15; //Tamaño de la pelota
    puntos = 0; //Puntos del jugador
    
    //La posicion de la pelota será justo arriba de la base del jugador
    posicion = new PVector(posicion_.x, posicion_.y - tamano);
    
    //Su velocidad y direccion será valores aleatorios en X y Y
    velocidad = new PVector(random(4, 6), random(-6, -5));
  }
  
  //Metodo para volver a posicionar la pelota en la base de jugador, en el caso de que este la haya perdido
  void setPosicion(PVector posicionJugador) {
    posicion = new PVector(posicionJugador.x, posicionJugador.y - tamano); 
    velocidad = new PVector(random(4, 6), random(-6, -5));  
  }
  
  //Dibuja la pelota en la pantalla
  void mostrar() {
    fill(#1AFFE2);
    noStroke();
    ellipse(posicion.x, posicion.y, tamano, tamano);
  }
  
  
  //Metodo para mover la pelota
  void mover() {
    //A la posicion se le suma el vector velocidad
    posicion.add(velocidad);
  }
  
  //Metodo para rebotar la pelota
  void rebotar(PVector posicionJugador, int anchoJugador, int altoJugador) {
    //Valor maximo en el eje x que ocupa la base del jugador
    float max = posicionJugador.x + anchoJugador/2; 
    
    //Valor minimo en el eje x que ocupa la base del jugador
    float min = posicionJugador.x - anchoJugador/2;
    
    //Si la posicion de la pelota esta dentro del area encerrada por estas condicionales(la base del jugador)
    //quiere decir que la pelota esta tocando la base del jugador, por lo tanto rebotará
    if(posicion.y > posicionJugador.y - altoJugador/2 
          && posicion.y < posicionJugador.y + altoJugador/2
          && posicion.x < max && posicion.x > min) {
            
      velocidad.y *= -1; //Se invierte el valor de la velocidad en y, haciendo que la pelota rebote
    }
  }
  
  //Metodo para rebotar en las paredes, excepto la pared inferior
  void validarBordes() {
    //Si la pelota toca la pared izquierda o derecha, rebotará en direccion contraria
    if(posicion.x < 0 || posicion.x > width) {
      velocidad.x *= -1; //Se invierte la velocidad, o sea se invierte la direccion
    } 
    //Si la pelota toca la pared superior, rebotará en direccion contraria
    else if(posicion.y < 0) {
      velocidad.y *= -1;
    }
  }
  
  //Metodo para validar si el jugador ha perdido la pelota (si la pelota sobrepasó la pared inferior)
  boolean validarMuerte() {
    //Si la pelota sobrepasó el suelo, entonces se perdió la pelota
    if(posicion.y > height) {
      return true;
    } 
    //Si no, entonces no ha pasado nada :)
    else {
      return false;
    }
  }
  
  //El metodo más dificil xd
  
  void eliminarBlock(ArrayList<PVector> blocks, ArrayList<Integer> colores,int ancho, int alto) {
    
    //Se evaluará cada bloque 
    for(int i = 0; i < blocks.size(); i++) {
      PVector block = blocks.get(i); //Se obtiene el bloque en la posicion i
      
      /*Si la posicion de la pelota esta dentro del area encerrada por esta condicion (el area del bloque), 
      entonces se evaluará en que lado del bloque chocó la pelota */
      if(posicion.x >= block.x - tamano/2 && posicion.x <=  block.x + ancho + tamano/2 && posicion.y > block.y - tamano/2 && posicion.y < block.y + alto + tamano/2) {
        
        //Si la pelota chocó con el lado izquierdo del bloque, rebotará en dirección contraria
        if(posicion.y <= block.y + alto && posicion.y >= block.y 
            && posicion.x >= block.x) {
          velocidad.x *= -1;    
        
        } 
        //Si la pelota chocó con el lado derecho del bloque, rebotará en dirección contraria
        else if(posicion.y <= block.y +alto && posicion.y >= block.y
            && posicion.x <= block.x + ancho) {
          velocidad.x *= -1;      
        
        } 
        //Si la pelota chocó con el lado inferior del bloque, rebotará en dirección contraria
        else if(posicion.x <= block.x + ancho + tamano && posicion.x >= block.x - tamano
            && posicion.y <= block.y + alto + tamano) {
          velocidad.y *= -1; 
         
        } 
        //Si la pelota chocó con el lado superior del bloque, rebotará en dirección contraria
        else if(posicion.x <= block.x + ancho + tamano && posicion.x >= block.x - tamano
            && posicion.y >= block.y - tamano) {
          velocidad.y *= -1;
        }
        
        //Se elimina el bloque con el que ha chocado la pelota
        blocks.remove(i);
        //Y se elimina su color correspodiente
        colores.remove(i);
        //El puntaje del jugador aumenta, 100 puntos más
        puntos += 100;
      }
    }
  }
  
  int getPuntos() {
    return puntos;
  } 
}
