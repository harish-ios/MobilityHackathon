//
//  ViewController.swift
//  BookYourNeed
//
//  Created by Intelligrape on 21/12/2014.
//  Copyright (c) 2014 com.ttndevelopem. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

  @IBOutlet weak var mapView: MKMapView!
  
  let regionRadius: CLLocationDistance = 1000
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set initial location in Honolulu
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    centerMapOnLocation(initialLocation)
    
    loadInitialData()
    mapView.addAnnotations(artworks)
    
    mapView.delegate = self
    

  }
  
  var artworks = [Artwork]()
  func loadInitialData() {
    
    let fileName = NSBundle.mainBundle().pathForResource("PublicArt", ofType: "json");
    var readError : NSError?
    var data: NSData = NSData(contentsOfFile: fileName!, options: NSDataReadingOptions(0), error: &readError)!
    
    
    var error: NSError?
    let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData(data,
      options: NSJSONReadingOptions(0), error: &error)
    
    
    if let jsonObject = jsonObject as? [String: AnyObject] where error == nil,
    
    let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
      for artworkJSON in jsonData {
        if let artworkJSON = artworkJSON.array,
        
        artwork = Artwork.fromJSON(artworkJSON) {
          artworks.append(artwork)
        }
      }
    }
  }
  
  func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
      regionRadius * 2.0, regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  

}

