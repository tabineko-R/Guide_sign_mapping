import UIKit
import GoogleMaps
import GooglePlaces

class DirectionsViewController: UIViewController {
    
    var present_latitude = 0 //緯度
    var present_longitude = 0 //経度
    var destination_latitude = 0
    var destination_longtude = 0
    
    var number = 0
    var landmarkText:String = ""
    
    

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
        let camera = GMSCameraPosition.camera(withLatitude: 41.764183, longitude: 140.716228, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 41.764183, longitude: 140.716228)
        marker.title = "現在地"
        marker.snippet = "現在地"
        marker.map = mapView
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 41.765183, longitude: 140.716228)
        marker2.title = "現在地"
        marker2.snippet = "現在地"
        marker2.map = mapView

    }
}
