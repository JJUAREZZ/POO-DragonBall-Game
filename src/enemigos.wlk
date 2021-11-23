import wollok.game.*
import pantallainicio.*
import disparos.*
import movimientos.*
import personajes.*

class Enemigo {
	var property position = game.at(0, 0)
	var danio = 0
	var property velocidad = 0
	var property vida = 0
	var personaje = nivel.personaje()
	var images = ["img/majinbooContento.png"]
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
			game.removeVisual(self)
			game.removeVisual(invisible)
			configRondas.listaEnemigos().add(self)
		}
	}
}

object majinboo inherits Enemigo {
	method aparecer(nuevaPosition) {
		position = nuevaPosition
	}
	method danio(nuevoDanio) {
		danio = nuevoDanio
	}
	method velocidad(nuevaVelocidad) {
		velocidad = nuevaVelocidad
	}
	method vida(nuevaVida) {
		vida = nuevaVida
	}
	method enojarse() {
		image = "img/majinbooEnojado.png"
		game.say(self, "Ahora vas a ver!")
	}
	override method estoyMuerto(invisible) {
		if(vida == 0) {
			game.removeVisual(self)
			game.removeVisual(invisible)
			personaje.murioElBoss()
		}
	}
}

class Invisible {
	var personaje = nivel.personaje()
	var position
	var enemigoASeguir
	var property soyEnemigo = true
	 
	method image() = "img/image (1).png"
	method position() = enemigoASeguir.position().up(1)
	method perderVida(cantidad) {
		enemigoASeguir.perderVida(cantidad)
		enemigoASeguir.estoyMuerto(self)
		if(majinboo.vida() == 8) {
			majinboo.enojarse()
		}
	}
}

object configRondas {
	const personaje = nivel.personaje()
	const property listaEnemigos = [""]
	var property rondaActual = 1
	
	method aparecerEnemigos(ronda) {
		game.schedule(2000, {
			ronda.nuevaRonda()
		})
	} 
	method cambioDeRonda(rondaSigueinte) {
		rondaActual += 1
		game.addVisual(round)
		round.cambioDeRonda(rondaActual)
		self.aparecerEnemigos(rondaSigueinte)
	}
}

object rondaEnCurso {
	const personaje = nivel.personaje()

	method empezarRonda(danio, velocidad, vida, images, cantEnemigos, rondaSiguiente) {
		game.onTick(1500, "nueva ronda", {
			if(self.noSuperoLaCantDeEnemigos(cantEnemigos)){
				var enemigo = new Enemigo(position = game.at(self.aparecerRandom(), 2), danio = danio, velocidad = velocidad, vida = vida, images = images)
				var invisible = new Invisible(position = game.at(enemigo.position().x(), 3), enemigoASeguir = enemigo)	
				self.nuevoEnemigo(enemigo)
				self.nuevoInvisible(invisible)		
			} else {
					configRondas.cambioDeRonda(rondaSiguiente)
					game.removeTickEvent("nueva ronda")	
			}
		})
	}
	method noSuperoLaCantDeEnemigos(cantEnemigos) {
		return configRondas.listaEnemigos().size() < cantEnemigos
	}
	method bossFinal(danio, velocidad, vida, image) {
		majinboo.aparecer(game.at(self.aparecerRandom(), 2))
		majinboo.danio(danio)
		majinboo.velocidad(velocidad)
		majinboo.vida(vida)
		var invisible = new Invisible(position = game.at(majinboo.position().x(), 3), enemigoASeguir = majinboo)	
		self.nuevoEnemigo(majinboo)
		self.nuevoInvisible(invisible)
	}
	method nuevoEnemigo(enemigo) {
		game.addVisual(enemigo)
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

object rondaUno{
	var property rondaSiguiente = rondaDos
	method nuevaRonda() {
		rondaEnCurso.empezarRonda(2, 300, 1, ["img/piccolo.png", "img/raditz.png", "img/mrsatan.png"], 11, rondaSiguiente)
	}
}

object rondaDos {
	var property rondaSiguiente = rondaFinal
	method nuevaRonda() {
		rondaEnCurso.empezarRonda(5, 700, 3, ["img/freezer.png", "img/breerus.png", "img/cell.png"], 21, rondaSiguiente)
	}
}

object rondaFinal{
	method nuevaRonda() {
		rondaEnCurso.bossFinal(10, 1000, 10, ["img/majinbooContento.png"])
	}
}
