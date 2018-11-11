class Campeon {
	const property puntosDeVidaBase = 0 
	const property puntosDeAtaqueBase = 0
	var property puntosDeDanio = 0
	var property cantidadDeBloqueos = 0
	const items = #{}
	var property dinero = 0
	
	method estaMuerto() = self.puntosDeVida() <= puntosDeDanio
	
	method puntosDeVida() = puntosDeVidaBase + items.sum({item => item.puntosDeVidaEquipamiento(self)})
	
	method puntosDeAtaque() = puntosDeAtaqueBase + items.sum({item => item.puntosDeAtaqueEquipamiento(self)})
	
	method activarHabilidad(item){
		item.activarHabilidad(self)
	}
	
	method comprar(item){
		if(dinero >= item.precio()){
			dinero -= item.precio()
			self.equipar(item)
		}
		else{
			self.error("No se tiene dinero suficiente para comprar este item")
		}
	}
	
	method vender(item){
		dinero += item.precio() / 2
		item.desequipar()
	}
	
	method equipar(item) {
		items.add(item)
		item.equipar (self)
	}
	
	method desequipar (item) {
		items.remove(item)	
		item.desequipar(self)
	}
	
	method atacar(oleada){
		dinero += oleada.cantidadMinions().min(self.puntosDeAtaque())
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
	var property puntosDanio = 0
	const property cantidadMinionsBase = 0
	var property plus = 0
	method recibirAtaqueDe(campeon){
		if(not self.estaMuerta()){
			self.recibirDanio(campeon.puntosDeAtaque())
			self.defenderseDe(campeon)
		}
	}
	method defenderseDe(campeon){
		campeon.recibirDanio(self.cantidadMinions() + plus)
	}
	method recibirDanio(cantidad){
		puntosDanio += cantidad
	}
	method cantidadMinions() = (cantidadMinionsBase - puntosDanio).max(0)
	method estaMuerta() = cantidadMinionsBase <= puntosDanio
}


