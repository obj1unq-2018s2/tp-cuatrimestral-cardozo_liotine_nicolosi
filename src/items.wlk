


class AnilloDeDoran {
	//	method equipar (campeon) {
	//	campeon.items().add(self)
	//	campeon.puntosDeDanio() += 5
	// 	campeon.puntosDeVida() += 60
	//	campeon.puntosDeAtaque() += 15
	//	}
	//	method desequipar (campeon) {
	//	campeon.items().remove(self)
	//	campeon.puntosDeDanio() -= 10
	//	} matias
	
	method puntosDeVidaEquipamiento(campeon) = 60
	method puntosDeAtaqueEquipamiento(campeon) = 15
	method puntosDeDanioEquipamiento() = 5
	method bloqueosEquipamiento() = 0
	method puntosDeDanioDesequipamiento() = -10
	method bloqueosDesequipamiento() = 0
}



class TomoAmplificador {
	//	method equipar (campeon) {
	//	campeon.items().add(self)
	//	campeon.cantidadDeBloqueos() += 2
	// 	campeon.puntosDeVida() += campeon.puntosDeDanio() * 0.25
	//	campeon.puntosDeAtaque() += campeon.puntosDeDanio() * 0.05
	//	}
	//	method desequipar (campeon) {
	//	campeon.items().remove(self)
	// 	campeon.cantidadDeBloqueos() += 1
	//	campeon.puntosDeDanio() += 30
	//	} matias
	
	method puntosDeVidaEquipamiento(campeon) = campeon.puntosDeDanio() * 0.25
	method puntosDeAtaqueEquipamiento(campeon) = campeon.puntosDeDanio() * 0.05
	method puntosDeDanioEquipamiento() = 0
	method bloqueosEquipamiento() = 2
	method puntosDeDanioDesequipamiento() = 30
	method bloqueosDesequipamiento() = 1
}



class SombreroDeRabadon inherits TomoAmplificador {
	override method puntosDeVidaEquipamiento(campeon) = super(campeon) + 5
	override method puntosDeAtaqueEquipamiento(campeon) = campeon.puntosDeAtaqueBase() * 2 //modificado para que sea puntos de ataque base y no una alteracion de estos. matias
	override method puntosDeDanioEquipamiento() = super() + 5
	override method puntosDeDanioDesequipamiento() = 0 //deberian borrarse con la modificacion que hice. matias
	override method bloqueosDesequipamiento() = 0 //deberian borrarse con la modificacion que hice. matias
}