import wollok.game.*
import pantallainicio.*
import disparos.*
import movimientos.*
import personajes.*

class Enemigo {
	var property position
	var danio
	var property velocidad
	var personaje = nivel.personaje()
	
	method moverse(nuevaPosition) {
		position = nuevaPosition
	}
	method atacar() {
		personaje.perderVida(danio)
	}
	 
}
class EnemigoRondaUno inherits Enemigo {
	var images = ["img/piccolo.png", "img/raditz.png", "img/mrsatan.png"]
	var image = images.anyOne()
	
	method image() = image
	method enojarse() {}
}
class EnemigoRondaDos inherits Enemigo {
	var images = ["img/freezer.png", "img/breerus.png", "img/cell.png"]
	var image = images.anyOne()
	
	method image() = image
	method enojarse() {}
}
class BossFinal inherits Enemigo {
	var image = "img/majinbooContento.png"
	
	method image() = image
	method enojarse() {
		image = "img/majinbooEnojado.png"
		game.say(self, "Ahora vas a ver!")
	}
}

class Invisible {
	var personaje = nivel.personaje()
	var property position
	var vida
	var enemigoASeguir
	 
	method image() = "img/image (1).png"
	method perseguirEnemigo() {
		game.onTick(100, "perseguir enemigo", {self.moverse(game.at(enemigoASeguir.position().x(), 3))})
	}
	method moverse(nuevaPosicion) {
		position = nuevaPosicion
	}
	method perderVida(cantidad) {
		vida = (vida - cantidad).max(0)
		self.estoyMuerto()
		if(vida == 8) {
			enemigoASeguir.enojarse()
		}
	}
	method estoyMuerto() {
		if(vida == 0) {
			personaje.sumarKill()
			game.removeVisual(self)
			game.removeVisual(enemigoASeguir)
		}
	}
}

object enemigos {
	const property listaEnemigos = []
	const property listaInvisibles = []
	const property rondaUno = []
	const property rondaDos = []
	
	method aparecerEnemigos() {
		game.onTick(2000, "ronda uno", {
			if(listaEnemigos.size() <= 6) {
				var enemigo = new EnemigoRondaUno(position = game.at(self.aparecerRandom(), 2), danio = 1, velocidad = 500)
				var invisible = new Invisible(position = game.at(enemigo.position().x(), 3), vida = 1, enemigoASeguir = enemigo)	
				self.nuevoEnemigo(enemigo)
				self.nuevoInvisible(invisible)
			} else {
				game.removeTickEvent("ronda uno")
			}
		})
		game.onTick(5000, "ronda dos", {
			if(listaEnemigos.size() > 6 && listaEnemigos.size() <= 12) {
				var enemigo = new EnemigoRondaDos(position = game.at(self.aparecerRandom(), 2), danio = 2, velocidad = 700)
				var invisible = new Invisible(position = game.at(enemigo.position().x(), 3), vida = 2, enemigoASeguir = enemigo)	
				self.nuevoEnemigo(enemigo)
				self.nuevoInvisible(invisible)
			} 
		})
		game.onTick(8000, "boss final", {
			if(listaEnemigos.size() == 13){
				var boss = new BossFinal(position = game.at(self.aparecerRandom(), 2), danio = 10, velocidad = 1000)
				var invisible = new Invisible(position = game.at(boss.position().x(), 3), vida = 10, enemigoASeguir = boss)	
				self.nuevoEnemigo(boss)
				self.nuevoInvisible(invisible)
			}
		})
		
	}
	method nuevoEnemigo(enemigo) {
		game.addVisual(enemigo)
		listaEnemigos.add(enemigo)
		self.activarPersecucionEnemigo(enemigo)
	}
	method activarPersecucionEnemigo(enemigo) {
		if(listaEnemigos.size() >= 1) activador.perseguirPersonaje(enemigo)
	}	
	method nuevoInvisible(invisible) {
		game.addVisual(invisible)
		listaInvisibles.add(invisible)
		self.activarPersecucionInvisible(invisible)
	}
	method activarPersecucionInvisible(invisible) {
		if(listaInvisibles.size() >= 1) invisible.perseguirEnemigo()
	}
	method aparecerRandom() {
		var extremos = [0, game.width()]
		return extremos.anyOne()
	}
}
