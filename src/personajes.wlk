import wollok.game.*
import pantallainicio.*
import disparos.*
import movimientos.*
import enemigos.*

class Personaje {
	var property position = game.at(15, 2)
	var property vida = 10
	var impactos = 0
	var property muertesTotales = 0
	
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
			game.say(self, "F")
			game.schedule(1500, {game.stop()})
		}
	}
	method sumarKill() {
		muertesTotales+=1
		if(muertesTotales == 22){
			game.say(self, "winner winner chicken dinner")
			game.schedule(1500, {game.stop()})
		}
	}
	method sumarImpacto() {
		impactos+=1
		if(impactos >= 5 && !game.hasVisual(ultiActiva)) game.addVisual(ultiActiva)
	}
}

object goku inherits Personaje {
	var image = "img/goku1.png"
	
	method image() = image
	method disparar(direccion) {
		const ataque = new AtaqueGoku(position = game.at(self.position().x(), 3), direccion = direccion)
		game.addVisual(ataque)
		ataque.movete()
		config.colisionDisparoPersonaje(ataque)
	}
	method ulti(direccion) {
		if(impactos >= 5) {
			const ulti = new UltiGoku(position = game.at(self.position().x(), 3), direccion = direccion)
			game.addVisual(ulti)
			ulti.movete()
			config.colisionDisparoPersonaje(ulti)
			impactos = 0
		} else {
			game.say(self, "Todavi no tengo la  ulti")
		}
	}
	method cambioDeRonda(ronda){
		image = "img/goku" + ronda + ".png"
	}
}

object vegeta inherits Personaje {
	var image = "img/vegeta1.png"
	
	method image() = image
	method disparar(direccion) {
		const ataque = new AtaqueVegeta(position = game.at(self.position().x(), 3), direccion = direccion)
		game.addVisual(ataque)
		ataque.movete()
		config.colisionDisparoPersonaje(ataque)
	}
	method ulti(direccion) {
		if(impactos >= 5) {
			const ulti = new UltiVegeta(position = game.at(self.position().x(), 3), direccion = direccion)
			game.addVisual(ulti)
			ulti.movete()
			config.colisionDisparoPersonaje(ulti)
			impactos = 0
		} else {
			game.say(self, "Todavia no tengo la  ulti")
		}
	}
	method cambioDeRonda(ronda){
		image = "img/vegeta" + ronda + ".png"
	}
}

object ultiActiva {
	
	method position() = game.at(24, 9.5)
	method image() = "img/ultimate.png"
}
