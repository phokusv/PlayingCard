//
//  ViewController.swift
//  PlayingCard
//
//  Created by VJB on 11/08/2018.
//  Copyright © 2018 VJB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var paquet = PaquetDeCarte()
    
    
    // Mise en place de la carte a afficher...
    @IBOutlet var ViewCarteAJouer: ViewCartes! { didSet {
        ViewCarteAJouer.carte = paquet[0]
       
        // ... et du swipe vers la gauche (envoyer premier carte au fond)
        let swipeVersGauche = UISwipeGestureRecognizer(target: self, action: #selector(carteSuivante))
        swipeVersGauche.direction = .left
        ViewCarteAJouer.addGestureRecognizer(swipeVersGauche)
       
        // ... et du swipe vers la droite (envoyer derniere carte en haut de paquet)
        let swipeVersDroite = UISwipeGestureRecognizer(target: self, action: #selector(carteDuFond))
        swipeVersDroite.direction = .right
        ViewCarteAJouer.addGestureRecognizer(swipeVersDroite)
        
        // ... et du tap pour retourner une carte
        let tapSurCarte = UITapGestureRecognizer(target: self, action: #selector(tap))
        ViewCarteAJouer.addGestureRecognizer(tapSurCarte)
        
        
        }
    }
    
    
    
    // Fonctions de mouvement des cartes en cas de UIGestureRecognizer
    @objc func carteSuivante() {
        paquet.envoyerPremiereCarteAuFond()
        ViewCarteAJouer.carte = paquet[0]
    }
    
    @objc func carteDuFond() {
        paquet.envoyerDerniereCarteEnHaut()
        ViewCarteAJouer.carte = paquet[0]
    }
    
    @objc func tap() {
        ViewCarteAJouer.carte.visible = !ViewCarteAJouer.carte.visible
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
}

