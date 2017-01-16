//
//  CharacterCell.swift
//  YugiExercise
//
//  Created by Brett Foreman on 1/14/17.
//  Copyright © 2017 Brett Foreman. All rights reserved.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var character: MarvelCharacter!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0  // sets the collection view cell to having rounded corners... 
    }
    
    func configureCell(_ character: MarvelCharacter) {
        // modifies and updates each cell as this function is called..., you want to create as many custom classes as possible, modularize things!
        // connects from char on VC
        
        self.character = character
        
        nameLbl.text = self.character.name.capitalized
        thumbImg.image = UIImage(named: "\(self.character.characterId)")
        // this connected the lbl and image of the cell in the collection view with data from our class... We have a string because it's actually an Int
        // Make sure to connect the collection view cell with this class "Character Cell" so it can communicate these things to it...  
    }
    
    
}
