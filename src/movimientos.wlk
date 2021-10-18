import wollok.game.*
import personajes.*
import disparos.*
import pantallainicio.*
import enemigos.*

object config {
	method configurarTeclas(personaje) {
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
	method colisionDisparoPersonaje() {
		
	}
}
