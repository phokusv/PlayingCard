//
//  CarteAJouer.swift
//  PlayingCard
//
//  Created by VJB on 11/08/2018.
//  Copyright © 2018 VJB. All rights reserved.
//

import Foundation

struct Carte {
    
    // Proprietes de la structure Carte
    var couleur: Couleur
    var hauteur: Hauteur
    var visible: Bool

    
    // Definition des couleurs
    enum Couleur: String {
        case pique = "♠️"
        case coeur = "♥️"
        case carreau = "♦️"
        case trefle = "♣️"
        static var univers = [pique, coeur, carreau, trefle]
    }
    
    // Definition des hauteurs (avec rang de 1 a 13 en valeur associee)
    // TODO: differencier jeux selon place de l'As (creer nouvelle structure ?)
    enum Hauteur:Int {
        
        case As = 1, deux, trois, quatre, cinq, six, sept, huit, neuf, dix, valet, reine, roi
        
        static var univers: [Hauteur] {
            var toutesHauteur: [Hauteur] = []
            for rang in 1...13 {
                toutesHauteur.append(Hauteur(rawValue: rang)!)
            }
            return toutesHauteur
        }
        
        var valeurAlphanumerique: String {
            get {
                switch self {
                case .As: return "A"
                case .deux, .trois, .quatre, .cinq, .six, .sept, .huit, .neuf, .dix: return String(self.rawValue)
                case .valet: return "J"
                case .reine: return "Q"
                case .roi: return "K"
                }
            }
        }
        
    }
    
    
    
    
}

// Adjonction des extensions utiles
// TODO: Ajouter un cycle entre les cartes (Pique coeur carreau trefle avec valeurs)

extension Carte: CustomStringConvertible {
    // Simplification du format des prints dans la console
    var description: String { return String(hauteur.rawValue) + couleur.rawValue + String(visible) }
}

