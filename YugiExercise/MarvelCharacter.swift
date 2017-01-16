//
//  MarvelCharacter.swift
//  YugiExercise
//
//  Created by Brett Foreman on 1/14/17.
//  Copyright © 2017 Brett Foreman. All rights reserved.
//

import Foundation
import Alamofire

class MarvelCharacter {
    // what does each need to start? Name and ID maybe
    private var _name: String!
    private var _characterId: Int!
    
    private var _height: String!
    private var _birthYear: String!
    private var _mass: String!
    private var _gender: String!
    private var _species: String!
    private var _homeWorld: String!
    private var _characterURL: String!
    
    
    
    // we want to protect the data and provide that theres an actual value for everything even if there isn't anything returned we will assume an empty string...
    
    var homeWorld: String {
        if _homeWorld == nil {
            _homeWorld = ""
        }
            return _homeWorld
        }
    
    var species: String {
            if _species == nil {
                _species = ""
            }
                return _species
            }
    
    var gender: String {
            if _gender == nil {
                _gender = ""
            }
                return _gender
            }
    
    var mass: String {
            if _mass == nil {
                _mass = ""
            }
                return _mass
            }
    
    var birthYear: String {
                if _birthYear == nil {
                    _birthYear = ""
                }
                    return _birthYear
                }
    
    var height: String {
            if _height == nil {
                _height = ""
            }
                return _height
        }

    
    
    var name: String {
        return _name
    }
    var characterId: Int {
        return _characterId
    }
    
    
    
    
    init(name: String, characterId: Int) { //Int
        self._name = name
        self._characterId = characterId
        
        self._characterURL = "\(URL_BASE)\(URL_CHARACTER)\(self.characterId)/"
        // this is the link to the exact character.. /1/ /2/ etc...
    }
    
    
    
    
    // whenever we click on one pokemon, it's then that we want to make the network call and load in that data, lazy loading...
    // Initially we'd like to have all cells update and stuff, but it'll cause a loading issue with capacity if we do that off viewdidload everytime... therefore we need to create a closure to help initialize the whole process... 
    
    func downloadCharacterDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_characterURL).responseJSON { response in
           if let dict = response.result.value as? Dictionary<String, Any>  {
                if let height = dict["height"] as? String {
                    self._height = height.capitalized
            }
                if let mass = dict["mass"] as? String {
                    self._mass = mass.capitalized
            }
                if let birthYear = dict["birth_year"] as? String {
                    self._birthYear = birthYear.capitalized
            }
                if let gender = dict["gender"] as? String {
                    self._gender = gender.capitalized
            }
            
            print(self._mass)
            print(self._height)
            print(self._birthYear)
            print(self._gender)
            
             // these ones are deeper set than the others... 
            
            if let homeWorld = dict["homeworld"] as? String {
                self._homeWorld = homeWorld.capitalized
            }
            
            
            if let species = dict["species"] as? [Dictionary<String, String>] {
                if let name = species[0]["name"] {
                    self._species = name.capitalized
                }
            }
        }
            completed() // let function know that it's been complete
    }
}
}


























