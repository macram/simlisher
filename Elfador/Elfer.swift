//
//  Elfer.swift
//  Elfador
//
//  Created by Manu Mateos on 16/8/17.
//  Copyright © 2017 Liquid Squad. All rights reserved.
//

import Foundation

class Elfer {
    let vocales = ["a", "e", "i", "o", "u", "a", "e", "i", "o", "u", "a", "e", "i", "o", "u", "á", "à", "é", "è", "ú", "ù", "â", "ê", "ô", "ø", "å", "œ"]
    let vocalesTildadas = ["á", "à", "é", "è", "ú", "ù", "â", "ê", "ô", "ø", "å", "œ"]
    let diptongos = ["ui", "iu", "ai", "ei", "oi", "au", "eu", "ou", "io"]
    let consonantesFinales = ["s", "r", "n", "n"]
    let consonantes = ["b", "c", "c", "c", "d", "d", "f", "f", "f", "g", "g", "j", "l", "l", "l", "m", "m", "n", "n", "p", "r", "s", "r", "s", "t", "r", "s", "t", "v", "v", "w", "x", "z", "ß"]
    let combinacionesConsonantes = ["br", "cr", "fr", "gr", "pr", "tr", "bl", "cl", "fl", "gl", "pl"]
    let consonantesRaras = ["w", "x", "z"]
    
    enum Estados {
        case Vocal
        case DeVocalAConsonante
        case Consonante
        case DeConsonanteAVocal
        case ConsonanteLuegoConsonante
        case Diptongo
        case FinalSilaba
    }
    
    var estado: Estados = .Vocal
    
    func getSilaba(palabra: String) -> String {
        var silaba = ""
        
        estado = getState(palabra: palabra)
        
        while estado != Estados.FinalSilaba {
            switch(estado) {
            case .Vocal:
                silaba += getLetra(strings: vocales)
                let sig = Int(arc4random_uniform(4))
                switch(sig) {
                case 0: estado = Estados.FinalSilaba
                default: estado = Estados.DeVocalAConsonante
                }
            case .DeVocalAConsonante:
                silaba += getLetra(strings: consonantesFinales)
                estado = Estados.FinalSilaba
            case .Consonante:
                silaba += getLetra(strings: consonantes)
                estado = Estados.DeConsonanteAVocal
            case .DeConsonanteAVocal:
                silaba += getLetra(strings: vocales)
                estado = Estados.FinalSilaba
            case .ConsonanteLuegoConsonante:
                silaba += getLetra(strings: combinacionesConsonantes)
                estado = Estados.DeConsonanteAVocal
            case .Diptongo:
                silaba += getLetra(strings: diptongos)
                let sig = Int(arc4random_uniform(2))
                switch(sig) {
                case 0: estado = Estados.DeVocalAConsonante
                default: estado = Estados.FinalSilaba
                }
            default: break
            }
        }
        
        return silaba
    }
    
    func getPalabra(maxLength: Int = Int.max) -> String {
        var sirve = false
        var palabra = ""
        
        while !sirve {
            palabra = ""
            let silabas = Int(arc4random_uniform(3)) + 1
            for _ in 0...silabas {
                palabra += getSilaba(palabra: palabra)
            }
            
            var countRaras = 0
            var tildadas = 0
            
            for i in 0..<palabra.count {
                if consonantesRaras.contains(palabra[i]) {
                    countRaras += 1
                }
                if vocalesTildadas.contains(palabra[i]) {
                    tildadas += 1
                }
            }
            if countRaras <= 1 && tildadas < 3 && palabra.count <= maxLength {
                sirve = true
            }
            
        }
        
        return palabra
    }
    
    func getState(palabra: String) -> Estados {
        if !palabra.isEmpty {
            if vocales.contains(String(describing: palabra.last!)) {
                return Estados.Consonante
            }
            else if consonantesFinales.contains(String(describing: palabra.last!)) {
                return Estados.Vocal
            }
        } else {
            let numero = Int(arc4random_uniform(3))
            
            switch numero {
            case 0: return Estados.Vocal
            case 1: return Estados.Consonante
            case 2: return Estados.ConsonanteLuegoConsonante
            default: return Estados.FinalSilaba
            }
        }
        return Estados.FinalSilaba
    }
    
    func getVocal() -> String {
        let numero = Int(arc4random_uniform(UInt32(vocales.count)))
        return vocales[numero]
    }
    
    func getConsonanteFinal() -> String {
        let numero = Int(arc4random_uniform(UInt32(consonantesFinales.count)))
        return consonantesFinales[numero]
    }
    
    func getLetra(strings: [String]) -> String {
        let numero = Int(arc4random_uniform(UInt32(strings.count)))
        return strings[numero]
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}
