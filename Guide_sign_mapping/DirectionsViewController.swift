import UIKit
import GoogleMaps
import GooglePlaces

class DirectionsViewController: UIViewController {
    
    //緯度経度はDouble型で記述
    var present_latitude = 0.0 //緯度
    var present_longitude = 0.0 //経度
    var destination_latitude = 41.7676953
    var destination_longtude = 140.7016394
    
    var number = 0
    var landmarkText:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyCUAnxANAd4CADFuJQEA_NqZvehGfRrMKs")
        
        //緯度、経度の変数設定
        switch landmarkText{
        case "旧ロシア領事館":
            destination_latitude = 41.7676953
            destination_longtude = 140.7016394
        case "太刀川家住宅（重要文化財）":
            destination_latitude = 41.7712556
            destination_longtude = 140.7063324
        default:
            break
        }
        
        
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
        marker2.position = CLLocationCoordinate2D(latitude: destination_latitude, longitude: destination_longtude)
        marker2.title = landmarkText
        marker2.snippet = landmarkText
        marker2.map = mapView
        
    }
}
