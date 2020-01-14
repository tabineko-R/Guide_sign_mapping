import UIKit
import ARKit

final class ViewController: UICollectionViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBOutlet weak var navItem: UIBarButtonItem!
    // NOTE: The imageConfiguration is better for tracking images,
    // but it has less features,
    // for example it does not have the plane detection.
    let defaultConfiguration: ARWorldTrackingConfiguration = {
        let configuration = ARWorldTrackingConfiguration()
        
        let images = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)
        configuration.detectionImages = images
        configuration.maximumNumberOfTrackedImages = 1
        return configuration
    }()
    
    let imageConfiguration: ARImageTrackingConfiguration = {
        let configuration = ARImageTrackingConfiguration()
        
        let images = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)
        configuration.trackingImages = images!
        configuration.maximumNumberOfTrackedImages = 1
        return configuration
    }()
    
    
    private var buttonNode: SCNNode!
    private var buttonNode2: SCNNode!
    private let feedback = UIImpactFeedbackGenerator()
    
    var alertController: UIAlertController!
    
    let Landmarks:[[String]] = [
        ["船見公園","Funami_park"],
        ["函館山","Hakodate_mountain"],
        ["函館公園","Hakodate_park"],
        ["函館駅","Hakodate_station"],
        ["元町公園","Motomachi_park"],
        ["周辺施設","Nearby_facilities"],
        ["赤レンガ倉庫","Red_brick_warehouse"],
        ["ロープウェイ山麓駅","Roopway_station"],
        ["立町岬","Tachimachi_misaki"]
    ]
    
    var selectText:String = ""
    var facilitiesText:String = ""
    
    let Facilities: [[String]] = [["エリア別表示","Area","Area"],
                                  ["観光施設","Tourist Facilities","Landmark"],
                                  ["観光案内所", "Toulist Information Center","TIC"],
                                  ["駐車場","Parking","Parking"],
                                  ["トイレ",  "Toilet","Toilet"],
                                  ["車いす対応トイレ", "Toilet(Whellchair Accessible)","WAToilet"],
                                  ["郵便局",  "Post Office","Post_Office"],
                                  ["ホテル",  "Hotel",  "Hotel"],
                                  ["金融機関", "Bank", "Bank"],
                                  ["警察署・交番", "Police Station/Box", "Police"],
                                  ["消防署","Firehouse","Firehouse"],
                                  ["学校", "School","School"],
                                  ["駅・電停",  "Railway Station/Streetcar Stop" ,"Station"]]
    
    
    
    
    private var cellSize: CGSize {
        let width = collectionView.bounds.width * 0.3
        let height = width
        return CGSize(width: width, height: height)
    }
    
    private var headerSize: CGSize {
        let width = collectionView.bounds.width * 0.3
        return CGSize(width: width, height: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        
        //tab
        collectionView.decelerationRate = .fast
        
        let flowLayout = collectionViewLayout as! FlowLayout
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = cellSize
        flowLayout.minimumInteritemSpacing = collectionView.bounds.height
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 500, left: 40, bottom: 0, right: 40)
        
        //ARオブジェクト配置
        //初期表示
        buttonNode = SCNScene(named: "art.scnassets/sign01/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "\(Facilities[2][2])", recursively: false)
        let thumbnailNode = buttonNode.childNode(withName: "pins", recursively: false)?.childNode(withName: "pin01", recursively: false)
        thumbnailNode?.geometry?.firstMaterial?.diffuse.contents =  UIImage(named: Facilities[2][2])
        
        if(facilitiesText == Facilities[0][2]){
             buttonNode = SCNScene(named: "art.scnassets/sign01/Areas.scn")!.rootNode.childNode(withName: "\(Facilities[0][2])", recursively: false)
        }
        
        for i in 1 ..< Facilities.count{
            if(facilitiesText == Facilities[i][2]){
                buttonNode = SCNScene(named: "art.scnassets/sign01/Guide_sign_mapping.scn")!.rootNode.childNode(withName: "\(Facilities[i][2])", recursively: false)
                    let thumbnailNode = buttonNode.childNode(withName: "pins", recursively: false)?.childNode(withName: "pin0\(i)", recursively: false)
                thumbnailNode?.geometry?.firstMaterial?.diffuse.contents =  UIImage(named: Facilities[i][2])
                navItem.title = Facilities[i][0]
                navItem.tintColor = UIColor.white
            }else if(facilitiesText == ""){
                navItem.title = ""
            }
        }
    }
    
    //AR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.run(imageConfiguration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    
    
    //tabbar
    //collectionの位置
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //初期位置
        let indexPath = IndexPath(item: 2, section: 0)
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        
        for i in 0 ..< Facilities.count{
            if(facilitiesText == Facilities[i][2]){
                collectionView.scrollToItem(at: IndexPath(item: i, section: 0), at: .centeredHorizontally, animated: false)
              let cella = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: IndexPath(item: i, section: 0)) as! Cell
                cella.contentView.backgroundColor = .red
                        
            }
        }
    }
    
    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return Facilities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell

        cell.label.text =  "\(Facilities[indexPath.row][0])"
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: Facilities[indexPath.row][2])
        
        return cell
    }
    
    // Cell が選択された場合
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath){
        
        selectText = Facilities[indexPath.row][2]
        
        if(Facilities[indexPath.row][2] == Facilities[0][2]){
            let storyboard: UIStoryboard = self.storyboard!
            let toSelectArea = storyboard.instantiateViewController(withIdentifier: "selectArea") as! FirstScreenViewController
            self.navigationController?.pushViewController(toSelectArea, animated: true)
        }else if(Facilities[indexPath.row][2] == Facilities[1][2]){
            let storyboard: UIStoryboard = self.storyboard!
            let toLandmarks = storyboard.instantiateViewController(withIdentifier: "selectGenre") as! SelectGenreViewController
            self.navigationController?.pushViewController(toLandmarks, animated: true)
        }else{
        performSegue(withIdentifier: "toViewControllerReload", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toViewControllerReload"){
            let VC: ViewControllerReload = (segue.destination as? ViewControllerReload)!
            VC.facilitiesText = selectText
        }
        }
 
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil))
        present(alertController, animated: true)
    }
    
    @IBAction func buttonEvent(_ sender: UIBarButtonItem) {
        let storyboard: UIStoryboard = self.storyboard!
            let toPictgrams = storyboard.instantiateViewController(withIdentifier: "pictgram") as! PictgramsViewController
            toPictgrams.pictgramText = facilitiesText
        if(facilitiesText == ""){toPictgrams.pictgramText = "TIC"}
            self.navigationController?.pushViewController(toPictgrams, animated: true)
    }
    

    
    }

extension ViewController: ARSCNViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return nil
        }
        
        //画像が認識された時に表示するscnのswitch文
        switch imageAnchor.referenceImage.name {
        case "information_sign" :
            DispatchQueue.main.async {
                self.feedback.impactOccurred()
            }
            return buttonNode
        default:
            return nil
        }
        
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let collectionView = scrollView as! UICollectionView
        (collectionView.collectionViewLayout as! FlowLayout).prepareForPaging()
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection _: Int) -> CGSize {
        return headerSize
    }
}
