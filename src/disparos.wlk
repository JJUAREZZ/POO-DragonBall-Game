import wollok.game.*
import pantallainicio.*
import movimientos.*
import personajes.*
import enemigos.*

class Ataque {
	var property position
	var danio = 1
	
	method hacia(direccion) {
		if(direccion == 1) {
			game.onTick(200, "moverIzq", {
					position = position.left(1)
		} else {
			game.onTick(200, "moverDer", {
					position = position.right(1)
			})
		}
	}
	method colision(enemigo) {
		 enemigo.perderVida(danio)
		 game.removeVisual(self)
	}
}

class AtaqueGoku inherits Ataque {
	method image() = "img/ataque.png"
}

class AtaqueVegeta inherits Ataque {
	method image() = "img/ataqueVegeta.png"
}

