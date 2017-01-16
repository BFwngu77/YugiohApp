//
//  CharacterDetailsViewController.swift
//  YugiExercise
//
//  Created by Brett Foreman on 1/15/17.
//  Copyright © 2017 Brett Foreman. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var birthYearLbl: UILabel!
    @IBOutlet weak var massLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var speciesLbl: UILabel!
    @IBOutlet weak var homeWorldLbl: UILabel!
    
    @IBOutlet weak var currentCharacterImg: UIImageView!
    
    
    
    var character: MarvelCharacter!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = character.name
        
        let img = UIImage(named: "\(character.characterId)")
        currentCharacterImg.image = img
        

        
        character.downloadCharacterDetails {
            print("Did arrive here!") //test
            // Whatever we write here will only be clled after the network call is complete! JSON/PARSE
            self.updateUI()
        }
        
    }

    func updateUI() {
        heightLbl.text = character.height
        birthYearLbl.text = character.birthYear
        massLbl.text = character.mass
        genderLbl.text = character.gender
        speciesLbl.text = character.species
        homeWorldLbl.text = character.homeWorld
        
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        // takes us back to our home view
    }
   
    



}
