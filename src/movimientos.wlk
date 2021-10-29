import wollok.game.*
import personajes.*
import disparos.*
import pantallainicio.*
import enemigos.*

object config {
	var personaje = nivel.personaje()
	method configurarTeclas() {
		keyboard.left().onPressDo({ 
           personaje.moverseIzq()
        })
        keyboard.right().onPressDo({ 
            personaje.moverseDer()
        })
        keyboard.a().onPressDo({personaje.disparar(izquierda) })
   		keyboard.s().onPressDo({personaje.disparar(derecha) })
   		keyboard.d().onPressDo({personaje.ulti(izquierda) })
   		keyboard.f().onPressDo({personaje.ulti(derecha) })
	}
	method configurarColisiones() {
		game.onCollideDo(personaje, {enemigo => enemigo.atacar()})
	}
	method colisionDisparoPersonaje(disparo) {
		game.onCollideDo(disparo, {invisible => disparo.colision(invisible)})
	}
}

object activador {
	method perseguirPersonaje(enemigo) {
		game.onTick(enemigo.velocidad(), "perseguir personaje", {perseguirPersonaje.perseguir(enemigo)})
	}
}

object perseguirPersonaje {
	const personaje = nivel.personaje()
	
	method perseguir(enemigo) {
		if(enemigo.vida() == 0){
			game.removeTickEvent("perseguir personaje")
		} else {
			self.nuevaPosicion(enemigo)	
		}
	}
	method nuevaPosicion(enemigo) {
		if(self.personajeALaIzq(enemigo)) {
			self.irIzq(enemigo)
		} else if(self.personajeALaDer(enemigo)){
			self.irDer(enemigo)
		}
	}
	method personajeALaIzq(enemigo) {
		return (enemigo.position().x() > personaje.position().x())
	}
	method personajeALaDer(enemigo) {
		return (enemigo.position().x() < personaje.position().x())
	}
	method irIzq(enemigo) {
		enemigo.moverse(enemigo.position().left(1))
	}
	method irDer(enemigo) {
		enemigo.moverse(enemigo.position().right(1))
	}
}


