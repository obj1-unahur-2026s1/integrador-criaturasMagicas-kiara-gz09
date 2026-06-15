import criaturas.*
object parque{}

//Areas
class Colonia {
    const property habitantes = []
    method poderOfensivo() = habitantes.sum{h => h.poderOfensivo()} 
    method intentarConquistar(unArea) {
        if (self.poderOfensivo() > unArea.poderDefensivo()){
            unArea.colonia(self)
            
        }else{
            habitantes.forEach{h => h.perderPoderMagico(h.poderMagico()*0.85)}
        }
    }
    method cantHabitantesFormidables() = habitantes.count{h => h.esFormidable()}
}

class Area {
    var property colonia
    method poderDefensivo()

}
class Claro inherits Area {
    override method poderDefensivo() {
        return 100 + colonia.poderOfensivo()
    }
}

class Castillo inherits Area {
    override method poderDefensivo() {
        return 200 * colonia.cantHabitantesFormidables()
    }
}


