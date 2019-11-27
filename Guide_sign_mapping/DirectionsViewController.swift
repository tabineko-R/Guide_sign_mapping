//
//  DirectionsViewController.swift
//  Guide_sign_mapping
//
//  Created by yuya on 2019/11/26.
//  Copyright © 2019 yuya. All rights reserved.
//

import UIKit
import GoogleMaps

class DirectionsViewController: UIViewController {
    
    var present_latitude = 0 //緯度
    var present_longitude = 0 //経度
    var destination_latitude = 0
    var destination_longtude = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyCUAnxANAd4CADFuJQEA_NqZvehGfRrMKs")
        
        /* //緯度、経度の変数設定
         switch number{
         case 1
         //いど軽度の関数
         case 2
         case 3
         }
         */
        
        // google map
        let camera = GMSCameraPosition.camera(withLatitude: 41.764183, longitude: 140.716228, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
