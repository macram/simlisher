//
//  main.swift
//  Elfador
//
//  Created by Manu Mateos on 16/8/17.
//  Copyright © 2017 Liquid Squad. All rights reserved.
//

import Foundation

let elfer = Elfer()

let maxLength = 1000
var texto = ""
var palabrasEnFrase = 0
var palabrasParaEstaFrase = 0

while texto.count < maxLength {
    if palabrasParaEstaFrase == 0 {
        palabrasParaEstaFrase = Int(arc4random_uniform(4) + 2)
    }
    palabrasEnFrase += 1
    texto += elfer.getPalabra(maxLength: maxLength-texto.count)
    
    if palabrasEnFrase >= palabrasParaEstaFrase {
        palabrasParaEstaFrase = 0
        palabrasEnFrase = 0
        texto += ". "
    }
    else {
        texto += " "
    }
}

texto += "flarlarLÂR. "

print(texto)
