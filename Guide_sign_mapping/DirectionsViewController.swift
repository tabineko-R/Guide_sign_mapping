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
        case "中華会館":
            destination_latitude = 0.0
            destination_longtude = 0.0
            case "新島襄海外渡航の地碑":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "旧函館区公会堂（重要文化財）":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "旧北海道庁 函館支庁庁舎・旧開拓使書籍庫(観光案内所・写真歴史館)":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "旧イギリス領事館（開港記念館）":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "ペリー提督来航記念碑":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "北方民族資料館":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "日本基督教団函館教会":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "郷土資料館（旧金森洋物店）":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "函館市文学館":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "金森美術館（バカラコレクション）":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "北海道第一歩の地碑":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "遊覧船のりば":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "北方歴史資料館":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "函館高田屋嘉兵衛資料館":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "函館明治館（旧函館郵便局）":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "カトリック元町教会":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "ハリストス正教会（重要文化財）":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "聖ヨハネ教会":
                destination_latitude = 0.0
                destination_longtude = 0.0
            case "東本願寺函館別院（重要文化財）":
                destination_latitude = 0.0
                destination_longtude = 0.0
        default:
            destination_latitude = 0.0
            destination_longtude = 0.0
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
        
        mapView.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
        
    }
}
