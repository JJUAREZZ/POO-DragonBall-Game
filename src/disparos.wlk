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
	var property soyEnemigo = false
	var image
	
	method image() = image
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

class Ultimate inherits Ataque{
	override method colision(enemigo) {
		 enemigo.perderVida(danio)
	}
}

class Direc {
	method izquierda(objeto) {
		if(tablero.enElTablero(objeto)) {
			objeto.nuevaPosicion(objeto.position().left(1))	
		} else {
			objeto.desaparecer()
		}	
	}
	method derecha(objeto) {
		if(tablero.enElTablero(objeto)) {
			objeto.nuevaPosicion(objeto.position().right(1))	
		} else {
			objeto.desaparecer()
		}
	}
}

object izquierda inherits Direc {
	method moverse(objeto) {
		self.izquierda(objeto)
	}
}

object derecha inherits Direc{
	method moverse(objeto) {
		self.derecha(objeto)
	}
}

object tablero {
	method enElTablero(objeto) {
		return (objeto.position().x() > -9 && objeto.position().x() < game.width() + 1)
	}
}

