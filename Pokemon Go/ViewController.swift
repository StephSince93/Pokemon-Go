//
//  ViewController.swift
//  Pokemon Go
//
//  Created by Stephen Romero on 4/17/17.
//  Copyright © 2017 Stephen Romero. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    
    var updateCount = 0
    
    var pokemons: [Pokemon] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemons = getAllPokemon()
        
        manager.delegate = self
        
        //checks if user allows their location to be used, then will find location on the map
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("All set!")
            //finds the location of the user
            mapView.showsUserLocation = true
            
            manager.startUpdatingLocation()
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                //Spwans a pokemon
                print("Timer")
                
                if let coord = self.manager.location?.coordinate {
                    
                    let anno = MKPointAnnotation()
                    anno.coordinate = coord
                    
                    let randoLat = (Double(arc4random_uniform(200))  - 100.0) / 100000.0
                    let randoLon = (Double(arc4random_uniform(200))  - 100.0) / 100000.0
                    
                    anno.coordinate.latitude += randoLat
                    anno.coordinate.longitude += randoLon
                    
                    self.mapView.addAnnotation(anno)
                }
            })
            
            
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    //function updates the users location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //if statement limits the restriction on the user location auto lock so user can roam on map
        if updateCount < 3 {
            //gives the coordinates for the location based on the region
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 250, 250)
            
            //sets the region to the mapView and does not animate to save blockiness
            mapView.setRegion(region, animated: false)
            updateCount += 1
        }
        else {
            manager.stopUpdatingLocation()
        }
    }
    
    @IBAction func centerTapped(_ sender: Any) {
        
        if let coord = manager.location?.coordinate {
            
            //gives the coordinates for the location based on the region
            let region = MKCoordinateRegionMakeWithDistance(coord, 250, 250)
            
            //sets the region to the mapView and does not animate to save blockiness
            mapView.setRegion(region, animated: true)
        }
    }
}

