import wollok.game.*
import pantallainicio.*
import disparos.*
import movimientos.*
import personajes.*

class Enemigo {
	var property position
	var danio
	var property velocidad
	var property vida
	var personaje = nivel.personaje()
	var images = []
	var image = images.anyOne()
	
	method image() = image
	method moverse(nuevaPosition) {
		position = nuevaPosition
	}
	method atacar() {
		personaje.perderVida(danio)
	}
	method perderVida(cantidad) {
		vida = (vida - cantidad).max(0)
	}
	method estoyMuerto(invisible) {
		if(vida == 0) {
			personaje.sumarKill()
			game.removeVisual(self)
			game.removeVisual(invisible)
		}
	}
	method enojarse() {
		image = "img/majinbooEnojado.png"
		game.say(self, "Ahora vas a ver!")
	}
}

class Invisible {
	var personaje = nivel.personaje()
	var position
	var enemigoASeguir
	 
	method image() = "img/image (1).png"
	method position() = enemigoASeguir.position().up(1)
	method perderVida(cantidad) {
		enemigoASeguir.perderVida(cantidad)
		enemigoASeguir.estoyMuerto(self)
		if(enemigoASeguir.vida() == 8) {
			enemigoASeguir.enojarse()
		}                                                                                                                                                                               
	}
}

object configRondas {
	const personaje = nivel.personaje()
	const property listaEnemigos = []
	var property rondaActual = 1
	
	method aparecerEnemigos(unaRonda) {
		game.onTick(1500, "ronda uno", {
			if(listaEnemigos.size() < 11) {
				ronda.empezarRonda(2, 300, 1, ["img/piccolo.png", "img/raditz.png", "img/mrsatan.png"])
			} else {
				game.removeTickEvent("ronda uno")
			}
		})
		game.schedule(23000, {
			self.cambioDeRonda()
			game.onTick(1500, "ronda dos", {
				if(listaEnemigos.size() >= 11 && listaEnemigos.size() < 21) {
					ronda.empezarRonda(5, 700, 3, ["img/freezer.png", "img/breerus.png", "img/cell.png"])
				} else if(listaEnemigos.size() == 21) {
					game.removeTickEvent("ronda dos")
				}
			})
		})
		game.schedule(48000, {
			self.cambioDeRonda()
			game.onTick(100, "boss final", {
				if(listaEnemigos.size() == 21){
					ronda.empezarRonda(10, 1000, 10, ["img/majinbooContento.png"])
				}
			})
		})
	}
	
	// unaRonda.iniciarRondas(listaEnemigos,self)
	

	method cambioDeRonda() {
		rondaActual += 1
		personaje.cambioDeRonda(rondaActual)
		round.cambioDeRonda(rondaActual)
		game.addVisual(round)
	}
}

object ronda {
	const personaje = nivel.personaje()
	
/* 	method iniciarRondas(listaDeEnemigos,configRonda){
		 if(listaDeEnemigos.size()<11){
			game.onTick(1500, "ronda uno", {
            self.empezarRonda(2, 300, 1, ["img/piccolo.png", "img/raditz.png", "img/mrsatan.png"])
			})}
			 else {
				game.removeTickEvent("ronda uno")
				self.iniciarRonda2(listaDeEnemigos,configRonda)
			}
}
	
	method iniciarRonda2(listaDeEnemigos,configRonda){
		  configRonda.cambioDeRonda()
		 if(listaDeEnemigos.size() >= 11 &&  listaDeEnemigos.size()< 21){
		 	game.onTick(1500, "ronda dos", {self.empezarRonda(5, 700, 3, ["img/freezer.png", "img/breerus.png", "img/cell.png"])
				})  if(listaDeEnemigos.size() == 21) {
					game.removeTickEvent("ronda dos")
					self.iniciarRondaFinal(configRonda)
					}
		 }
	}
	
	method iniciarRondaFinal(configRonda){
		 configRonda.cambioDeRonda()
		game.schedule(48000, {
			game.onTick(100, "boss final",{
					self.empezarRonda(10, 1000, 10, ["img/majinbooContento.png"])
				})
	     }
	     
	   )}
	
	*/
  method empezarRonda(danio, velocidad, vida, images) {
		
		var enemigo = new Enemigo(position = game.at(self.aparecerRandom(), 2), danio = danio, velocidad = velocidad, vida = vida, images = images)
		var invisible = new Invisible(position = game.at(enemigo.position().x(), 3), enemigoASeguir = enemigo)	
		self.nuevoEnemigo(enemigo)
		self.nuevoInvisible(invisible)	
	}
	method nuevoEnemigo(enemigo) {
		game.addVisual(enemigo)
		configRondas.listaEnemigos().add(enemigo)
		self.activarPersecucionEnemigo(enemigo)
	}
	method activarPersecucionEnemigo(enemigo) {
		activador.perseguirPersonaje(enemigo)
	}	
	method nuevoInvisible(invisible) {
		game.addVisual(invisible)
	}
	method aparecerRandom() {
		var extremos = [0, game.width()]
		return extremos.anyOne()
	}
}
