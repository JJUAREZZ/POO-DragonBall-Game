import wollok.game.*
import pantallainicio.*
import movimientos.*
import personajes.*
import enemigos.*

class Ataque {
	var property position
	var danio = 1
	var direccion
	var personaje = nivel.personaje()
	
	method movete() {
		game.onTick(200, "mover ataque", {
				direccion.moverse(self)		
		})
	}
	method nuevaPosicion(nuevaPosicion) {
		position = nuevaPosicion
	}
	method colision(enemigo) {
		 enemigo.perderVida(danio)
		 game.removeVisual(self)
		 personaje.sumarImpacto()
	}
	method desaparecer() {
		game.removeTickEvent("mover ataque")
	}
}

class AtaqueGoku inherits Ataque {
	method image() = "img/ataque.png"
}

class AtaqueVegeta inherits Ataque {
	method image() = "img/ataqueVegeta.png"
}

class Ultimate {
	var property position
	var danio = 4
	var direccion 
	
	method movete() {
		game.removeVisual(ultiActiva)
		game.onTick(200, "mover ulti", {
				direccion.moverse(self)		
		})
	}
	method nuevaPosicion(nuevaPosicion) {
		position = nuevaPosicion
	}
	method colision(enemigo) {
		 enemigo.perderVida(danio)
	}
	method desaparecer() {
		game.removeTickEvent("mover ulti")
		game.removeVisual(self)
	}
}

class UltiGoku inherits Ultimate {
	method image() = "img/ultiGoku.png"
}

class UltiVegeta inherits Ultimate {
	method image() = "img/ultiVegeta.png"
}

object izquierda {
	method moverse(objeto) {
		if(tablero.enElTablero(objeto)) {
			objeto.nuevaPosicion(objeto.position().left(1))	
		} else {
			objeto.desaparecer()
		}
	}
}

object derecha {
	method moverse(objeto) {
		if(tablero.enElTablero(objeto)) {
			objeto.nuevaPosicion(objeto.position().right(1))	
		} else {
			objeto.desaparecer()
		}
	}
}

object tablero {
	method enElTablero(objeto) {
		return (objeto.position().x() > -1 && objeto.position().x() < game.width() + 1)
	}
}

