import wollok.game.*
object pantalla {
	const ancho = 30
	const alto = 15
	
	method iniciar() {
		game.height(alto)
		game.width(ancho)
		game.title("DragonBall Figth")
		game.boardGround("img/background.gif")
		game.addVisual(goku)
		game.addVisual(majinBoo)
		//goku.animar()
		const cell = new Enemigo(velocidad=1, vida=100, danio=2,image="img/cell.png", positionX=10)
		game.addVisual(cell)
		majinBoo.animar()
		
		//game.onCollideDo(cell,{algo => algo.a()})
		
		keyboard.left().onPressDo({goku.moverseIzquierda()})
		keyboard.right().onPressDo({goku.moverseDerecha()})
		keyboard.a().onPressDo({goku.dispara(1) })
   		keyboard.s().onPressDo({goku.dispara(2) })
		// keyboard.t().onPressDo({goku.teletransportarse})
		
		game.start()
	}
	
	// Función que hizo el profesor en clase.
	/*
	method queNoSeSalga(posicion){
		var nuevaPos = posicion
		if(posicion.x() >= ancho) nuevaPos = game.at(ancho-1,nuevaPos.y())
		if(posicion.x() < 0) nuevaPos = game.at(0,nuevaPos.y())
		if(posicion.y() >= alto) nuevaPos = game.at(nuevaPos.x(),alto-1)
		if(posicion.y() < 0) nuevaPos = game.at(nuevaPos.x(),0)
		return nuevaPos
		
	}
	*/
}

class Enemigo {
	var property velocidad
	var property vida 
	var property danio
	var property image	
	var property positionX 
	var property positionY = 2	
	
	
	method position() {
		return game.at(positionX, positionY)	
	}
	method image() {
		return image
	}
	method perderVida(danioRecibido) {
		vida -= danioRecibido
		if(vida == 0) game.removeVisual(self)
	}
	method atacar() {
		
	}
}

class Ataque {
	var positionX
	var positionY = 3
	var property position = game.at(positionX, positionY)
	var danio = 100
	 
	method image() {
		return "img/ataque.png"
	}
	method hacia(direccion) {
		if(direccion == 1) {
			game.onTick(300, "moverIzq", {
				if(game.colliders(self) != []) {
					self.colision()
				} else {
					position = position.left(1)
				}
			})
		} else {
			game.onTick(300, "moverDer", {
				if(game.colliders(self) != []) {
					self.colision()
				} else {
					position = position.right(1)
				}
			})
		}
	}
	method colision() {
		 /*game.onCollideDo(self, {alguien => alguien.perderVida(danio)})
		 game.removeVisual(self)*/
	}
}

object goku {
	var property positionX = 15
	var property positionY = 2
	var position = game.at(positionX, positionY)
	var nro = 2
	var image = "img/goku0.png"
	// var property enemigos = [majinBoo, enemigo2, enemigo3, ...]
	
	method position() {
		return position
	}
	method image() {
		return image
	}
	method moverseIzquierda() {
		position = position.left(1)
	}
	method moverseDerecha() {
		position = position.right(1) 
	}
	method dispara(direccion) {
		const ataque = new Ataque(positionX = positionX)
		game.addVisual(ataque)
		ataque.hacia(direccion)
	}
	method a() {
		image = "img/goku1.png"
	}
	
	/*
	method teletransportarse() {
		var objetivo = enemigos.find({enemigo => game.hasVisual(enemigo)})
		self.position(objetivo.position)
	}
	*/
}

object majinBoo {
	var estadoAnimo = "Contento"
	
	method position() {
		return game.at(20,2)
	}
	method image() {
		return "img/majinboo"+estadoAnimo+".png"
	}
	method animar() {
		game.say(self, "Ahora vas a ver")
		game.schedule(6000, {estadoAnimo = "Enojado"})
	}
}
