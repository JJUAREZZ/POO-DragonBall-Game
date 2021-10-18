import wollok.game.*
import pantallainicio.*
import disparos.*
import movimientos.*
import enemigos.*

class Personaje {
	var property position = game.at(15, 2)
	var property vida = 100
	var muertesTotales = 0
	
	method moverseDer() {
		position = position.right(1)
	}
	method moverseIzq() {
		position = position.left(1)
	}
	method perderVida(cantidad) {
		vida = (vida - cantidad).max(0)
		self.estoyMuerto()
	}
	method estoyMuerto() {
		if(vida == 0) {
			game.say(self, "Game Over")
			game.schedule(3000, {game.stop()})
		}
	}
}

object goku inherits Personaje {
	method image() = "img/goku0.png"
	method disparar(direccion) {
		const ataque = new AtaqueGoku(position = self.position())
		game.addVisual(ataque)
		ataque.hacia(direccion)
	}
}

object vegeta inherits Personaje {
	
}
