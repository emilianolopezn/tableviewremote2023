//
//  Pelicula.swift
//  listaaa
//
//  Created by Alumno ULSA on 24/04/23.
//

import Foundation

class Pelicula : Decodable {
    var titulo : String
    var director : String
    var anno : String
    
    init(titulo: String, director: String, año: String) {
        self.titulo = titulo
        self.director = director
        self.anno = año
    }
}
