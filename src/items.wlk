
class AnilloDeDoran {
	method equipar(campeon) {
		campeon.puntosDeDanio(campeon.puntosDeDanio() + 5)
	}
	method desequipar (campeon) {
		campeon.puntosDeDanio((campeon.puntosDeDanio() - 10).max(0))
	}
	method puntosDeVidaEquipamiento(campeon) = 60
	method puntosDeAtaqueEquipamiento(campeon) = 15
	method precio() = 300
	method activarHabilidad(campeon){}
}



class TomoAmplificador {
	var usoHabilidad = false
	method equipar(campeon) {
		campeon.cantidadDeBloqueos(campeon.cantidadDeBloqueos() + 2)
	}
	method desequipar(campeon) {
	 	campeon.cantidadDeBloqueos(campeon.cantidadDeBloqueos() + 1)
		campeon.puntosDeDanio(campeon.puntosDeDanio() + 30)
	}
	method puntosDeVidaEquipamiento(campeon) = campeon.puntosDeDanio() * 0.25
	method puntosDeAtaqueEquipamiento(campeon) = campeon.puntosDeDanio() * 0.05
	method precio() = 500
	method activarHabilidad(campeon){
		if(not usoHabilidad){
			campeon.dinero(500.max(campeon.dinero()))
			usoHabilidad = true
		}
	}
}



class SombreroDeRabadon inherits TomoAmplificador {
	override method equipar(campeon){
		super(campeon)
		campeon.puntosDeDanio(campeon.puntosDeDanio() + 5)
	}
	override method desequipar(campeon){}
	override method puntosDeVidaEquipamiento(campeon) = super(campeon) + 5
	override method puntosDeAtaqueEquipamiento(campeon) = campeon.puntosDeAtaqueBase() * 2
	override method precio() = super() + 100
	override method activarHabilidad(campeon){}
}

class PocionDeVida {
	var usos = 2
	method equipar(campeon){}
	method desequipar(campeon){}
	method puntosDeVidaEquipamiento(campeon) = 0
	method puntosDeAtaqueEquipamiento(campeon) = 0
	method precio() = 50
	method activarHabilidad(campeon){
		if(usos > 0){
			campeon.puntosDeDanio((campeon.puntosDeDanio() - 50).max(0))
			usos -= 1
		}
	}
}

class BastonDeVacio {
	const materiales = #{}
	method agregar(item){
		materiales.add(item)
	}
	method equipar(campeon){}
	method desequipar(campeon){}
	method puntosDeVidaEquipamiento(campeon) = materiales.sum { material => material.puntosDeVidaEquipamiento(campeon) } / 2
	method puntosDeAtaqueEquipamiento(campeon) = materiales.sum { material => material.puntosDeAtaqueEquipamiento(campeon) }
	method precio() = 0
	method activarHabilidad(campeon){
		materiales.forEach { material => material.activarHabilidad(campeon) }
	}
}