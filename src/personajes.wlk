import wollok.game.*
import pantallainicio.*
import disparos.*
import movimientos.*
import enemigos.*

class Personaje {
	var property position = game.at(15, 2)
	var property vida = 10
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
			game.say(self, "Noo F")
			game.schedule(1500, {game.stop()})
		}
	}
	method sumarKill() {
		muertesTotales++
		if(muertesTotales == 22){
			game.say(self, "winner winner chicken dinner")
			game.schedule(1500, {game.stop()})
		}
	}
}

object goku inherits Personaje {
	var image = "img/goku1.png"
	
	method image() = image
	method disparar(direccion) {
		const ataque = new AtaqueGoku(position = game.at(self.position().x(), 3))
		game.addVisual(ataque)
		ataque.hacia(direccion)
		config.colisionDisparoPersonaje(ataque)
	}
	method cambioDeRonda(ronda){
		image = "img/goku" + ronda + ".png"
	}
}

object vegeta inherits Personaje {
	var image = "img/vegeta1.png"
	
	method image() = image
	method disparar(direccion) {
		const ataque = new AtaqueVegeta(position = game.at(self.position().x(), 3))
		game.addVisual(ataque)
		ataque.hacia(direccion)
		config.colisionDisparoPersonaje(ataque)
	}
	method cambioDeRonda(ronda){
		image = "img/vegeta" + ronda + ".png"
	}
}
