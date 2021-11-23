import wollok.game.*
import pantallainicio.*
import disparos.*
import movimientos.*
import enemigos.*

class Personaje {
	var property position = game.at(15, 2)
	var property vida = 10
	var impactos = 0
	var property image
	var property imageAtaque
	var property imageUlti
	
	
	method moverseDer() {
		position = position.right(1)
	}
	method moverseIzq() {
		position = position.left(1)
	}
	method disparar(direccion) {
		const ataque = new Ataque(position = game.at(self.position().x(), 3), direccion = direccion, image = imageAtaque)
		game.addVisual(ataque)
		ataque.movete()
		config.colisionDisparoPersonaje(ataque)
	}
	method ulti(direccion) {
		if(impactos >= 5) {
			const ulti = new Ultimate(position = game.at(self.position().x(), 3), direccion = direccion, image = imageUlti, danio = 4)
			game.addVisual(ulti)
			ulti.movete()
			game.removeVisual(ultiActiva)
			config.colisionDisparoPersonaje(ulti)
			impactos = 0
		} else {
			game.say(self, "Todavia no tengo la  ulti")
		}
	}
	method perderVida(cantidad) {
		vida = (vida - cantidad).max(0)
		self.estoyMuerto()
	}
	method estoyMuerto() {
		if(vida == 0) {
			game.say(self, "F")
			game.schedule(1500, {game.stop()})
		}
	}
	method sumarImpacto() {
		impactos+=1
		if(impactos >= 5 && !game.hasVisual(ultiActiva)) game.addVisual(ultiActiva)
	}
	method murioElBoss() {
		game.say(self, "winner winner chicken dinner")
		game.schedule(1500, {game.stop()})
	}
}

object ultiActiva {
	method position() = game.at(24, 9.5)
	method image() = "img/ultimate.png"
}
