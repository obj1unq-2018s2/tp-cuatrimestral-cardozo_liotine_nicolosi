
class AnilloDeDoran {
	const property precio = 0
	method equipar(campeon) {
		campeon.puntosDeDanio(campeon.puntosDeDanio() + 5)
	}
	method desequipar (campeon) {
		campeon.puntosDeDanio((campeon.puntosDeDanio() - 10).max(0))
	}
	method puntosDeVidaEquipamiento(campeon) = 60
	method puntosDeAtaqueEquipamiento(campeon) = 15
}



class TomoAmplificador {
	const property precio = 0
	method equipar(campeon) {
		campeon.cantidadDeBloqueos(campeon.cantidadDeBloqueos() + 2)
	}
	method desequipar(campeon) {
	 	campeon.cantidadDeBloqueos(campeon.cantidadDeBloqueos() + 1)
		campeon.puntosDeDanio(campeon.puntosDeDanio() + 30)
	}
	method puntosDeVidaEquipamiento(campeon) = campeon.puntosDeDanio() * 0.25
	method puntosDeAtaqueEquipamiento(campeon) = campeon.puntosDeDanio() * 0.05
}



class SombreroDeRabadon inherits TomoAmplificador {
	override method equipar(campeon){
		super(campeon)
		campeon.puntosDeDanio(campeon.puntosDeDanio() + 5)
	}
	override method desequipar(campeon){}
	override method puntosDeVidaEquipamiento(campeon) = super(campeon) + 5
	override method puntosDeAtaqueEquipamiento(campeon) = campeon.puntosDeAtaqueBase() * 2
}