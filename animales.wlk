class Animales{
  var property anuncio_fin = 0
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
    sed = false
    peso -= 1 
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

    self.sediento()
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
  var property juntos = []
  var property animal_a = 0
  var property animal_b = 0
  var property numero = 0
  var property posibilidades_de_enfermo = [false, true]
  var property contador = 0
  var posibilidad = false
 
  var ultimo = 0

  var property estado = 0

  const property lista_estados = [0, 1]

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
      if(animal.enfermo() == false){
        animal.vacunar()
      }
      else{
        animales.remove(animal)
      }
 
    } )
  }
 
  method almuerzo_completo(cantidad_alimento){
    animales.forEach({ animal =>  
      animal.comer(cantidad_alimento)
 
    } )
  }

  method hidratacion_completa(){
    animales.forEach({ animal =>  
      animal.tomar()
 
    } )
  }
 
// --- ENFERMAR ANIMALES ---

  method enfermar(animal){
   
    if(animales.get(animal).vacunado() == false){
      animales.get(animal).enfermo(true)
    }


  }

// --- ESTAR JUNTOS CON LA FAMILIA ---
 
    method juntos_abiertos(){

    animal_a = animales.anyOne()
    animal_b = animales.anyOne()

    if(animal_a != animal_b){
      juntos = [animal_a, animal_b]
      self.crear_crias()
    }
    else{self.juntos_abiertos()}

     
    }

    method crear_crias(){
      if(juntos.get(0).especie() == juntos.get(1).especie()){
        numero = 0.randomUpTo(3).roundUp()
            if(animal_a.enfermo() == false || animal_b.enfermo() == false){
       
                if(juntos.get(0).especie() == 'Vaca'){
                    numero.times({n => animales.add(new Vacas())})
                }
                else if(juntos.get(0).especie() == 'Cerdo'){
                    numero.times({n => animales.add(new Cerdos())})
                }
                else if(juntos.get(0).especie() == 'Pollo'){
                    numero.times({n => animales.add(new Pollos())})
        }
        }

            if(animal_a.enfermo() == true || animal_b.enfermo() == true){
               
                posibilidad = posibilidades_de_enfermo.anyOne()
       
                if(juntos.get(0).especie() == 'Vaca'){
                    numero.times({n => animales.add(new Vacas())
                      ultimo = animales.size() - 1
                      self.enfermar(ultimo)
                    })
                }
                else if(juntos.get(0).especie() == 'Cerdo'){
                    numero.times({n => animales.add(new Cerdos())
                      ultimo = animales.size() - 1
                      self.enfermar(ultimo)
                     
                    })
                }
                else if(juntos.get(0).especie() == 'Pollo'){
                    numero.times({n => animales.add(new Pollos())
                      ultimo = animales.size() - 1
                      self.enfermar(ultimo)
                    })
        }
        }
     
    }
    }


// --- ACCIONES ANIMALES INDIVIDUALES ---

  method vacunar(animal) {

    if(animales.get(animal).enfermo() == true){animales.remove(animales.get(animal))}
    else{animales.get(animal).vacunado(true) }
  }

  method tomar(animal) {
    animales.get(animal).tomar()
  }

  method comer(animal, cantidad) {
    animales.get(animal).comer(cantidad)
  }



// --- SIMULACION DE GRANJA ---

  method simulacion_diaria(){
    
    animales.forEach({ n=> 
    
      contador += 1

    

      if(n.enfermo() == true){ n.anuncio_fin(n.anuncio_fin() + 1) }
      else{n.anuncio_fin(0)}

      if(n.anuncio_fin() == 3){animales.remove(n)} 
     })

  }

}