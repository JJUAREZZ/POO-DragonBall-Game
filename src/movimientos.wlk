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
        keyboard.a().onPressDo({personaje.disparar(1) })
   		keyboard.s().onPressDo({personaje.disparar(2) })
   		/*keyboard.space().onPressDo({ 
           ataquePersonajes.disparar()
        })*/
	}
	method configurarColisiones() {
		game.onCollideDo(personaje, {enemigo => enemigo.atacar()})
	}
	method colisionDisparoPersonaje() {
		enemigos.listaInvisibles().forEach({enemigo => game.onCollideDo(enemigo, {disparo => disparo.colision(enemigo, disparo)})})
	}
}

object activador {
	method iniciar() {
		//game.start()
	}
	method perseguirPersonaje() {
		game.onTick(800, "perseguir personaje", {perseguirPersonaje.perseguir()})
	}
}

object perseguirPersonaje {
	const personaje = nivel.personaje()
	
	method perseguir() {enemigos.listaEnemigos().forEach({enemy => self.nuevaPosicion(enemy)})}
	method nuevaPosicion(enemy) {
		if(self.personajeALaIzq(enemy)) {
			self.irIzq(enemy)
		} else if(self.personajeALaDer(enemy)){
			self.irDer(enemy)
		}
	}
	method personajeALaIzq(enemy) {
		return (enemy.position().x() > personaje.position().x())
	}
	method personajeALaDer(enemy) {
		return (enemy.position().x() < personaje.position().x())
	}
	method irIzq(enemy) {
		enemy.moverse(enemy.position().left(1))
	}
	method irDer(enemy) {
		enemy.moverse(enemy.position().right(1))
	}
}
