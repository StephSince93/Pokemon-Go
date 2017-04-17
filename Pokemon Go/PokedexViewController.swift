//
//  PokedexViewController.swift
//  Pokemon Go
//
//  Created by Stephen Romero on 4/17/17.
//  Copyright © 2017 Stephen Romero. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var caughtPokemons: [Pokemon] = []
    var uncaughtPokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        caughtPokemons = getAllCaughtPokemons()
        uncaughtPokemons = getAllUncaughtPokemons()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //function that allows the number of sections user wants to use
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "CAUGHT"
        }else {
            return "UNCAUGHT"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return caughtPokemons.count
        }else{
            return uncaughtPokemons.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "HELLO THERE"
        return cell
    }

    @IBAction func mapTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
