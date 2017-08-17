//
//  main.swift
//  Simlisher
//
//  Created by Manu Mateos on 16/8/17.
//  Copyright © 2017 Liquid Squad. All rights reserved.
//

import Foundation

let simlisher = Simlisher()

let maxLength = 500
var texto = ""
var palabrasEnFrase = 0
var palabrasParaEstaFrase = 0

while texto.count < maxLength - 4 {
    if palabrasParaEstaFrase == 0 {
        palabrasParaEstaFrase = Int(arc4random_uniform(4) + 2)
    }
    var palabra = simlisher.getPalabra(maxLength: maxLength-texto.count)
    
    if palabrasEnFrase == 0 {
        palabra = palabra.capitalized
    }
    
    texto += palabra
    palabrasEnFrase += 1
    
    
    if palabrasEnFrase >= palabrasParaEstaFrase {
        palabrasParaEstaFrase = 0
        palabrasEnFrase = 0
        texto += ". "
    }
    else {
        texto += " "
    }
}

texto += "FlarlarLÂR. "

print(texto)
