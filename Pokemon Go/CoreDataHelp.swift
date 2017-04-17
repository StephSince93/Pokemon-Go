//
//  CoreDataHelp.swift
//  Pokemon Go
//
//  Created by Stephen Romero on 4/17/17.
//  Copyright © 2017 Stephen Romero. All rights reserved.
//

import UIKit
import CoreData

func addAllPokemon(){
    
    
    createPokemon(name: "Charmander", imageName: "charmander")
    createPokemon(name: "Bullbasaur", imageName: "bullbasaur")
    createPokemon(name: "Squirtle", imageName: "squirtle")
    createPokemon(name: "Pikachu", imageName: "pikachu")
    createPokemon(name: "Snorlax", imageName: "snorlax")
    createPokemon(name: "Dratini", imageName: "dratini")


    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}


func createPokemon(name: String, imageName: String){
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let pokemon = Pokemon(context: context)
    pokemon.name = name
    pokemon.imageName = imageName
    
}

func getAllPokemon() -> [Pokemon] {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   do{
   let pokemons =  try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
    
    if pokemons.count == 0 {
        addAllPokemon()
        
        return getAllPokemon()
    }
    
    return pokemons

   } catch{}
    
  return[]
}

func getAllCaughtPokemons() -> [Pokemon] {
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

     let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    
  //   fetchRequest.predicate = NSPredicate(format: "caught == %@", true)
    
    do{
     let pokemons =  try context.fetch(fetchRequest) as [Pokemon]
        
     return pokemons
       
    }catch{}
    
    return []
}

func getAllUncaughtPokemons() -> [Pokemon] {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    
 //   fetchRequest.predicate = NSPredicate(format: "caught == %@", false)
    
    do{
        let pokemons =  try context.fetch(fetchRequest) as [Pokemon]
        
        return pokemons
        
    }catch{}
    
    return []

    
}

