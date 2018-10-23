class Campeon{
	const puntosDeVida = 0
	const puntosDeAtaque = 0
	var property puntosDeDanio = 0
	var property cantidadDeBloqueos = 0
	const property items = #{}
	
	method estaMuerto() = puntosDeVida <= puntosDeDanio
	
	method puntosDeVida() = puntosDeVida + items.sum({item => item.puntosDeVidaEquipamiento()})
	
	method puntosDeAtaque() = puntosDeAtaque + items.sum({item => item.puntosDeAtaqueEquipamiento()})
	
	method equipar(item) {
		items.add(item)
		puntosDeDanio += item.puntosDeDanioEquipamiento(self)
		cantidadDeBloqueos += item.bloqueosEquipamiento()
	}
	
	method desequipar(item){
		items.remove(item)
		
	}
}



class AnilloDeDoran {
	method puntosDeVidaEquipamiento(campeon) = 60
	method puntosDeAtaqueEquipamiento(campeon) = 15
	method puntosDeDanioEquipamiento() = 5
	method bloqueosEquipamiento()
}



class TomoAmplificador {
	method puntosDeVidaEquipamiento(campeon) = campeon.puntosDeVida() * 0.25
	method puntosDeAtaqueEquipamiento(campeon) = campeon.puntosDeDanio() * 0.05
	method puntosDeDanioEquipamiento() = 0
}



class SombreroDeRabadon inherits TomoAmplificador {
	override method puntosDeVidaEquipamiento(campeon) = super(campeon) + 5
	override method puntosDeAtaqueEquipamiento(campeon) = campeon.puntosDeAtaque() * 2
	override method puntosDeDanioEquipamiento() = super() + 5
}




class Oleada {
	var property cantidadMinions = 0
	var property plus = 0
}
