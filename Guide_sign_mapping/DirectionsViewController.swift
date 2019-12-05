import UIKit
import MapKit

class DirectionsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    //緯度経度はDouble型で記述
    var present_latitude = 0.0 //緯度
    var present_longitude = 0.0 //経度
    var destination_latitude = 41.7676953
    var destination_longtude = 140.7016394
    
    var number = 0
    var landmarkText:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        print(landmarkText)
    
        let coordinate = CLLocationCoordinate2DMake(41.764183, 140.716228)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        //地図にピンを立てる。
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(41.7676953, 140.7016394)
        annotation.title = landmarkText
        annotation.subtitle = landmarkText
        mapView.addAnnotation(annotation)
        
        mapView.setRegion(region, animated:true)
        
    }
}
