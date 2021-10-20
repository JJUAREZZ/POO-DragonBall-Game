import wollok.game.*
import pantallainicio.*
import disparos.*
import movimientos.*
import personajes.*

class Enemigo {
	var property position
	var vida
	var danio
	var image
	var personaje = nivel.personaje()
	
	method image() = image
	method moverse(nuevaPosition) {
		position = nuevaPosition
	}
	method atacar() {
		personaje.perderVida(danio)
	}
	method perderVida(cantidad) {
		vida = (vida - cantidad).max(0)
		self.estoyMuerto()
	}
	method estoyMuerto() {
		if(vida == 0) {
			game.removeVisual(self)
		}
	} 
}

class Invisible {
	var property position
	 
	method image() = "img/image (1).png"
	method perseguirEnemigo(enemigo) {
		game.onTick(800, "perseguir enemigo", {self.moverse(game.at(enemigo.position().x(), 3))})
	}
	method moverse(nuevaPosicion) {
		position = nuevaPosicion
	}
}

object enemigos {
	var enemigo
	var invisible
	const property listaEnemigos = []
	const property listaInvisibles = []
	const property rondaUno = []
	const property rondaDos = []
	
	method aparecerEnemigos() {
		/*game.onTick(5000, "nuevo enemigo", {
			enemigo = new Enemigo(position = game.origin, vida = 1, danio = 1, image = "img/cell.png")
			self.nuevoEnemigo()
		})*/
		enemigo = new Enemigo(position = game.at(0, 2), vida = 1, danio = 1, image = "img/cell.png")
		invisible = new Invisible(position = game.at(enemigo.position().x(), 3))
		game.addVisual(invisible)
		listaInvisibles.add(invisible)
		invisible.perseguirEnemigo(enemigo) 
		self.nuevoEnemigo()
	}
	method nuevoEnemigo() {
		game.addVisual(enemigo)
		listaEnemigos.add(enemigo)
		self.activarPersecucion()
	}
	method activarPersecucion() {
		if(listaEnemigos.size() >= 1) activador.perseguirPersonaje()
	}	
}
