class Criatura {
    var property poderMagico
    const astucia
    var rol
    method poderOfensivo() = poderMagico * rol.extra() 
    method esFormidable() = self.esAstuta() or self.esExtraordinaria()
    method esAstuta()
    method esExtraordinaria()  
    method ritual(){
        rol = rol.cambioRol(self)
    }
    method perderPoderMagico(num) {
        poderMagico = poderMagico * 0.85
    }
}

class Duende inherits Criatura{
    override method poderOfensivo() = super() * 1.1
    override method esAstuta() = false
    override method esExtraordinaria() = rol.esExtraordinario(self)
}

class Hada inherits Criatura{
    var kilometrosQuePuedenVolar = 2

    method aumentarKilometros(unNum){
        kilometrosQuePuedenVolar = (kilometrosQuePuedenVolar + unNum).max(25)
        } 
    method kilometrosQuePuedenVolar() = kilometrosQuePuedenVolar 
    override method esAstuta() = astucia > 50 
    override method esFormidable() {
        return super() self.aumentarKilometros(10)
    }
    override method esExtraordinaria() = rol.esExtraordinario(self)
}

//ROLES

object guardian {
    method extra() = 100 
    method esExtraordinario(criatura) = criatura.poderMagico() > 50 
    method cambioRol(criatura) {
        const mascotita = new Mascota(tieneCuernos = false, edad = 1)
        return new Domador(mascotas = [mascotita])
    }
}

class Domador {
    const mascotas = []
    method cantMascotasConCuernos() = mascotas.count{m => m.tieneCuernos()} 
    method extra() = 150 * self.cantMascotasConCuernos() 
    method esExtraordinario(criatura) {
        return criatura.poderMagico() >= 15 && self.todasSonVeteranas() 
    }
    method todasSonVeteranas() = mascotas.all{m => m.esVeterana()}
    method cambioRol() {
        if (self.tieneAlgunaMascotaMagicaConCuernos())
            return hechizero
        else
            self.error("Ritual Cancelado")
    }
    method tieneAlgunaMascotaMagicaConCuernos() = mascotas.any{m => m.tieneCuernos()}
}

object hechizero {
    method extra() = 0 
    method esExtraordinario(criatura) = true
    method cambioRol(criatura) {
        return guardian
    }
}

//Mascotas 
class Mascota{
    const property tieneCuernos
    var edad
    method esVeterana() = edad >= 10 
}