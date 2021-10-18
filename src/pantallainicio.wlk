import wollok.game.*
import personajes.*
import disparos.*
import movimientos.*

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
		config.configurarTeclas(personaje)
	}
}
