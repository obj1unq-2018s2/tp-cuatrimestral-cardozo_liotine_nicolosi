class Campeon {
	const property puntosDeVidaBase = 0 
	const property puntosDeAtaqueBase = 0
	var property puntosDeDanio = 0
	var property cantidadDeBloqueos = 0
	const property items = #{}
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

	method atacar(enemigo){
//		dinero += enemigo.cantidadMinions().min(self.puntosDeAtaque())
		enemigo.recibirAtaqueDe(self)
	}
	
	method dineroQueRecibeAlAtacar(oleada) = oleada.cantidadMinions().min(self.puntosDeAtaque())
	
	method acumularDinero(cantidad) {
		dinero += cantidad
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

class Soporte inherits Campeon {
	var property campeonVinculado = null //de tipo campeon
	method inventario () {
		return items + campeonVinculado.items()
	}
	override method puntosDeVida () {
		return puntosDeVidaBase + self.inventario().sum({item => item.puntosDeVidaEquipamiento(self)})
	}
	override method puntosDeAtaque () {
		return puntosDeAtaqueBase + self.inventario().sum({item => item.puntosDeAtaqueEquipamiento(self)})
	}
	method vincularA (nuevoCampeon) {
		campeonVinculado = nuevoCampeon
	}
	override method atacar (enemigo) {
		dinero += enemigo.cantidadMinions().min(self.puntosDeAtaque())
		enemigo.recibirAtaqueDe(self)
		campeonVinculado.puntosDeDanio(campeonVinculado.puntosDeDanio() - 10)
	}
}

class Oleada {
	var property puntosDanio = 0
	const property cantidadMinionsBase = 0
	var property plus = 0
	method recibirAtaqueDe(campeon){
		if(not self.estaMuerta()){
			campeon.acumularDinero(campeon.dineroQueRecibeAlAtacar(self))
			self.defenderseDe(campeon)
			self.recibirDanio(campeon.puntosDeAtaque())
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




class EjercitoDeMinions {
	const property oleadas = #{}
	
	method estaMuerto(){
		return oleadas.all({oleada => oleada.estaMuerta()})
	}
	
	method recibirAtaqueDe(campeon){
		oleadas.forEach({oleada => oleada.recibirAtaqueDe(campeon)})
	}
	
//	method cantidadMinions(){
//		return oleadas.sum({oleada => oleada.cantidadMinions()})
//	}No hace falta. Resolvi el dinero de otra forma
}






