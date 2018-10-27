class Campeon{
	const puntosDeVida = 0
	const puntosDeAtaque = 0
	var property puntosDeDanio = 0
	var property cantidadDeBloqueos = 0
	const property items = #{}
	
	
	method estaMuerto() = puntosDeVida <= puntosDeDanio
	
	method puntosDeVida() = puntosDeVida + items.sum({item => item.puntosDeVidaEquipamiento(self)})
	
	method puntosDeAtaque() = puntosDeAtaque + items.sum({item => item.puntosDeAtaqueEquipamiento(self)})
	
	method equipar(item) {
		items.add(item)
		puntosDeDanio += item.puntosDeDanioEquipamiento()
		cantidadDeBloqueos += item.bloqueosEquipamiento()
	}
	
	method desequipar(item){
		items.remove(item)
		puntosDeDanio += item.puntosDeDanioDesequipamiento()
		cantidadDeBloqueos += item.bloqueosDesequipamiento()
	}
	
	method atacar(oleada){
		oleada.recibirAtaqueDe(self)
	}
	
	method recibirDanio(cantidad){
		puntosDeDanio += cantidad
	}
}

class Oleada {
	var property puntosVida = 0
	var property puntosDanio = 0
	var property cantidadMinions = 0
	var property plus = 0
	method recibirAtaqueDe(campeon){
		self.recibirDanio(campeon.puntosDeAtaque())
		self.defenderseDe(campeon)
	}
	method defenderseDe(campeon){
		campeon.recibirDanio(cantidadMinions + plus)
	}
	method recibirDanio(cantidad){
		puntosDanio += cantidad
	}
}

