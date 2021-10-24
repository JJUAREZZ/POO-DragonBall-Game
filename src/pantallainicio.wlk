import wollok.game.*
import personajes.*
import disparos.*
import movimientos.*
import enemigos.*

object startMenu {
	method iniciar() {
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
		game.clear()
		game.addVisual(personaje)
		game.addVisual(banner)
		game.addVisual(round)
		config.configurarTeclas()
		enemigos.aparecerEnemigos()
		config.configurarColisiones()
		round.cambioDeRonda(1)
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
	method cambioDeRonda(ronda) {
		image = "img/round" + ronda + ".png"
		game.schedule(2000, {game.removeVisual(self)})
	}
}


