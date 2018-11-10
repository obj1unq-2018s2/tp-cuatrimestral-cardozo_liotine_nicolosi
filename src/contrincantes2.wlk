class Campeon {
	const property puntosDeVidaBase = 0 
	const property puntosDeAtaqueBase = 0
	var property puntosDeDanio = 0
	var property cantidadDeBloqueos = 0
	const items = #{}
	
	
	method estaMuerto() = self.puntosDeVida() <= puntosDeDanio
	
	method puntosDeVida() = puntosDeVidaBase + items.sum({item => item.puntosDeVidaEquipamiento(self)})
	
	method puntosDeAtaque() = puntosDeAtaqueBase + items.sum({item => item.puntosDeAtaqueEquipamiento(self)})
	
	method equipar(item) {
		items.add(item)
		item.equipar (self)
	}
	
	method desequipar (item) {
		items.remove(item)	
		item.desequipar(self)
	}
	
	method atacar(oleada){
		oleada.recibirAtaqueDe(self)
	}
	
	method recibirDanio(cantidad){
		if(cantidadDeBloqueos > 0){
			cantidadDeBloqueos -= 1
		}
		else{
			puntosDeDanio += cantidad	
		}
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


