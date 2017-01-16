//
//  ViewController.swift
//  YugiExercise
//
//  Created by Brett Foreman on 1/14/17.
//  Copyright © 2017 Brett Foreman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {
// connect the collection view with the view controller... the code below acts upon the outlets placed here... 
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var character = [MarvelCharacter]() // connected to the parse func below
    var filteredCharacter = [MarvelCharacter]() // connects to search bar func
    var inSearchMode = false // connects to the search bar func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            collection.dataSource = self
            collection.delegate = self
            searchBar.delegate = self
        
            searchBar.returnKeyType = UIReturnKeyType.done
        
        
        parseStarwarsCSV() // calls it upon load...
    }
    
    func parseStarwarsCSV(){
        // path created to csv file
        let path = Bundle.main.path(forResource: "Starwars", ofType: "csv")!// force unwrap...
                                    // this is a change in newer versions, "forResource"
        // this will capture all of the data from the csv, but now we will need to parse it..
        do {
            //pulling out the rows and selecting the id and name that we want..
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                let charId = Int(row["id"]!)!
                let name = row["name"]!  // if we run this and get thrown an error it will catch an error below
                // then we create an object called "char" and we pass that into our character array above...
                let char = MarvelCharacter(name: name, characterId: charId)
                    character.append(char) // this is the array shown above...
            }
            
            
        } catch let err  as NSError {
            print(err.debugDescription)
        }
    }
    
    
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // this is where we want to create our cells...
    // shows only the main loaded ones, however many will be displayed at a time
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterCell {
    // here we are in deque reusable cell. We will make the images more dynamic... allowing them to show more than just prototype image... This is the marvelcharacter object...
            // assign that character at indexPath.row to char... 
                // be cognitive of why char is ":" and not "="
            let char: MarvelCharacter!
            
            if inSearchMode {
                
                char = filteredCharacter[indexPath.row]
                cell.configureCell(char)
                
            } else {
                char = character[indexPath.row]
                cell.configureCell(char)
                
            }
    // above line shows grabbing the pics by #
            
            return cell

        } else {
            
            return UICollectionViewCell() // This will return an empty generic cell, if not...
        }
    }
    
    
    
    // when you tap on a cell, this will execute
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // we want the segue to be called when someone selects a cell...
        
        var char: MarvelCharacter!
        // if in search mode we take it from filtered character list, otherwise from the original
        if inSearchMode {
            char = filteredCharacter[indexPath.row]
        } else {
            char = character[indexPath.row]
        }
        performSegue(withIdentifier: "CharacterDetailsViewController", sender: char)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredCharacter.count
        }
        return character.count // i have manually selected people/1-4/ 
                                // connected to the var at top of this VC
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 319, height: 259) 
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true) // when searchbar is pressed... 
        
    }
    
    
    //revolves around search bar text changing, what will happen?
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //when we aren't searching for anything we want it to display all, otherwise, display the ones we search...
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData() // if theres nothing or we erased what was in the searchbar, revert to the original data
            view.endEditing(true)
            
        } else {
            inSearchMode = true
            
              let lower = searchBar.text!.lowercased()
                                                // is it included in the range of the original name
            filteredCharacter = character.filter({$0.name.range(of: lower) != nil})
            collection.reloadData() // repopulates the collection view with new data
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // this happens before the segue occurs, sets data up to be passed between view controllers...
        if segue.identifier == "CharacterDetailsViewController" {
            if let detailsVC = segue.destination as? CharacterDetailsViewController {
                if let char = sender as? MarvelCharacter {
                    detailsVC.character = char
                }
            }
        }
    }
}




























