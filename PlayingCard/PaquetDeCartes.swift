//
//  PaquetDeCartes.swift
//  PlayingCard
//
//  Created by VJB on 11/08/2018.
//  Copyright © 2018 VJB. All rights reserved.
//

import Foundation

struct PaquetDeCarte {
    
    private(set) var cartesDuPaquet = [Carte]()
    
    // Introduction d'une fonction de tirage aleatoire d'une carte, la retirant du paquet
    mutating func retirerAuHasard() -> Carte? {
        if cartesDuPaquet.count > 0 {
            return cartesDuPaquet.remove(at: cartesDuPaquet.count.arc4random)
        } else {return nil}
    }
 
    // Introduction d'une fonction de tirage de la carte du dessus du paquet
    mutating func retirerPremiereCarte() -> Carte? {
        if cartesDuPaquet.count > 0 {
            return cartesDuPaquet.remove(at: 0)
        } else {return nil}
    }
    
    // Introduction d'une fonction de passage de la carte du dessus du paquet en derniere position du paquet
    mutating func envoyerPremiereCarteAuFond() {
        if cartesDuPaquet.count > 0 {
            let carteDeplacee = cartesDuPaquet.remove(at: 0)
            cartesDuPaquet.insert(carteDeplacee, at: cartesDuPaquet.count)
        }
    }

    // Introduction d'une fonction de passage de la carte du fond du paquet tout en haut paquet
    mutating func envoyerDerniereCarteEnHaut() {
        if cartesDuPaquet.count > 0 {
            let carteDeplacee = cartesDuPaquet.remove(at: cartesDuPaquet.count-1)
            cartesDuPaquet.insert(carteDeplacee, at: 0)
        }
    }
    
    // Definition de deux initialiseurs (1. sans nombre et 2. avec nombre de hauteurs (et non valeurs) precise
    init() {
        for hauteur in Carte.Hauteur.univers {
            for couleur in Carte.Couleur.univers {
                cartesDuPaquet.append(Carte(couleur: couleur, hauteur: hauteur, visible: true))
            }
        }
        cartesDuPaquet.shuffle()
    }
    
    
    init?(nombreDeValeursDeCartes: Int) {
        if nombreDeValeursDeCartes <= 0 || nombreDeValeursDeCartes > Carte.Hauteur.univers.count { return nil}
        else {for hauteur in ((Carte.Hauteur.univers.count-nombreDeValeursDeCartes + 1) ... Carte.Hauteur.univers.count).reversed() {
            for couleur in Carte.Couleur.univers {
                cartesDuPaquet.append(Carte(couleur: couleur, hauteur: Carte.Hauteur(rawValue: hauteur)!, visible: true))
            }
            }
        }
        cartesDuPaquet.shuffle()
    }

// Creation subscript pour faciliter code quand je prends des cartes
    subscript(index: Int) -> Carte {
        get {
            return cartesDuPaquet[index]
        }
        set(newValue) {
            cartesDuPaquet[index] = newValue
        }
    }
    
}

// Extension de Int pour introduire capacite d'alea
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else { return 0}
    }
}




// These extensions add a shuffle() method to any mutable collection (arrays and unsafe mutable buffers) and a shuffled() method to any sequence:

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
