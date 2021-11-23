import wollok.game.*
import personajes.*
import disparos.*
import movimientos.*
import enemigos.*

const opening = game.sound("opening.mp3")
const battle = game.sound("battle.mp3")
const goku = new Personaje(image = "img/goku1.png", imageAtaque = "img/ataque.png", imageUlti = "img/ultiGoku.png")
const vegeta = new Personaje(image = "img/vegeta1.png", imageAtaque = "img/ataqueVegeta.png", imageUlti = "img/ultiVegeta.png")

object startMenu {
	method iniciar() {
		opening.shouldLoop(true)
		game.schedule(500, { opening.play()} )
		opening.volume(0.1)
		seleccionador.seleccionarPersonaje()
		game.addVisualIn(pantallaMenu, game.at(10, 5))
	}	
}

object pantallaMenu {
	method image() = "img/pantallainicio.png"
}

object seleccionador {
	method seleccionarPersonaje() {
		keyboard.num0().onPressDo({ 
			nivel.personajeSeleccionado(vegeta)
			nivel.iniciar()
		})
		keyboard.num1().onPressDo({ 
			nivel.personajeSeleccionado(goku)
			nivel.iniciar()
		})
	}
}

object nivel {
	var personaje 
	method personaje() = personaje
	method personajeSeleccionado(personajeSeleccionado) {
		personaje = personajeSeleccionado
	}
	method iniciar() {
		opening.pause()
		
		game.clear()
		game.addVisual(personaje)
		game.addVisual(banner)
		game.addVisual(round)
		config.configurarTeclas()
		config.configurarColisiones()
		configRondas.aparecerEnemigos(rondaUno)
		round.cambioDeRonda(1)
		
		battle.shouldLoop(true)
		game.schedule(500, { battle.play()} )
		battle.volume(0.5)
	}
}

object banner {
	method image() = "img/banner.png"
	method position() = game.at(10, 9.5)
}

object round {
	var image 
	
	method image() = image
	method position() = game.at(9, 5)
	method cambioDeRonda(rondaActual) {
		image = "img/round" + rondaActual + ".png"
		game.schedule(2000, {game.removeVisual(self)})
	}
}


