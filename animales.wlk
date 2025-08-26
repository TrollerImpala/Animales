class Animales{
  var property hambre = true
  const property especie = 'Animal'
  var property sed = false
  var property vacunado = false 
  var property peso = 0 

  var property enfermo = false


  method comer(comida) {}

  method tomar() {}

  method vacunar() {}
}

//----------------------------------------------------------------------

class Vacas inherits Animales (peso = 50, especie = 'Vaca'){

  method hambriento() {
    if(peso < 400){hambre = true}
    else{hambre = false}
  }

  override method comer(comida){
    self.hambriento()
    if (hambre == true){ 
      peso += comida/2 
      sed = true
    }
    self.hambriento()
  }

  override method tomar(){
    if(sed == true){ peso -= 1 }
  }

  override method vacunar(){
    if (vacunado == false){vacunado = true}

  }


  method caminar(){
    peso -= 3
  }
  
}

//-------------------------------------------------------------------

class Cerdos inherits Animales (peso = 30, especie = 'Cerdo'){
  var property veces_c = 0

  override method comer(comida){
    self.hambriento()
    if(hambre == true){
      peso += comida - 5
    }
    if (sed == false){ veces_c += 1 }

    self.hambriento()
  }

  method hambriento() {
    if(peso < 200){hambre = true}
    else{hambre = false}
  }


  method sediento(){

    if (veces_c >= 3){ sed = true }

  }
  override method tomar(){
    self.sediento()
    veces_c = 0
    if (sed == true) { sed = false }
  }

  override method vacunar(){

    if(vacunado == false || vacunado == true){vacunado = true}

  }

}

//----------------------------------------------------------------------

class Pollos inherits Animales (peso = 4, especie = 'Pollo'){
  override method comer(comida){
    if(hambre == true){ peso += 0 }
  }

  override method tomar(){
    sed = false
  }

  override method vacunar(){
    return 'La gallina se escapa de la vacuna'
  }
}

//------------------------------------------------------------------

object granja{
  var property animales = []
  var property estados =  []

  // --- ESTADOS DE TODOS LOS ANIMALES ---
  method cuales_hambrientos(){
    estados = []
    animales.forEach({ animal =>
      if (animal.hambre() == true){ estados.add(animal) }
    })

    return estados
  }

  
  method cuales_sedientos(){
    estados = []
    animales.forEach({ animal =>
      if (animal.sed() == true){ estados.add(animal) }
    })
    return estados
  }


  method cuales_vacunados(){
    estados = []
    animales.forEach({ animal =>
      if (animal.vacunado() == true){ estados.add(animal) }
    })
    return estados
  }


  method cuales_no_vacunados(){
    estados = []
    animales.forEach({ animal =>
      if (animal.vacunado() == false){ estados.add(animal) }
    })
    return estados
  }

  // --- CREACION DE ANIMALES ---
  method crear_vacas(cantidad){
    cantidad.times({ n =>  animales.add( new Vacas() ) } )
  }

  method crear_cerdos(cantidad){
    cantidad.times({ n =>  animales.add( new Cerdos() ) } )
  }

  method crear_pollos(cantidad){
    cantidad.times({ n =>  animales.add( new Pollos() ) } )
  }


  // --- ACCIONAR A TODOS LOS ANIMALES ---

  method vacunacion_completa(){
    animales.forEach({ animal =>  
      if(animal.especie() != 'Pollo'){animal.vacunar()}
  
    } )
  }
  
  method almuerzo_completo(cantidad_alimento){
    animales.forEach({ animal =>  
      animal.comer(cantidad_alimento)
  
    } )
  }


}