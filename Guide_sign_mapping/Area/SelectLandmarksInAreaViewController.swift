import UIKit

class SelectLandmarksInAreaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet var TableView: UITableView!
    
   //prepareで使うためのワンクッション
   var selectText:String?
    var areaText:String?
   
   //配列landmarksを設定
   var landmarks: [String] = []
   
   //    //landmarksと数を一致させる let photos = ["russian","tachikawa","","","",""]
   
   
   
   
   override func viewDidLoad() {
       super.viewDidLoad()
       
       TableView = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
       TableView.delegate = self
       TableView.dataSource = self
       TableView.estimatedRowHeight = 100
       TableView.rowHeight = UITableView.automaticDimension
    
    
    switch areaText {
    case "周辺施設":
        landmarks = [""]
    case "函館公園周辺":
        landmarks = [""]
    case "ロープウェイ山麓駅周辺":
        landmarks = [""]
    case "元町公園周辺":
        landmarks = [""]
    case "赤レンガ倉庫周辺":
        landmarks = [""]
    case "函館駅周辺":
        landmarks = [""]
    case "函館山周辺":
        landmarks = [""]
    case "船見公園周辺":
        landmarks = [""]
    case "立待岬周辺":
        landmarks = [""]
    default:
        break
    }


   }
   
   //セクション数を指定
   func numberOfSections(in tableView: UITableView) -> Int {
       return 1
       
   }
   //セクションタイトルを指定
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       switch section{
       case 0:
           return "函館"
       default:
           return nil
       }
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return landmarks.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       // セルを取得する
       let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                  reuseIdentifier:"cell")
       
       switch indexPath.section {
       case 0:
           // セルに表示する値を設定する
           cell.textLabel!.text = landmarks[indexPath.row]
           //cell.imageView?.image = UIImage(named: photos[indexPath.row])
           
       default:
           break
       }
       
       return cell
   }
   
   //タップされた時
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       // タップされたセルの行番号を出力
       print("\(landmarks[indexPath.row])番目の行が選択されました。")
       // セルの選択を解除
       tableView.deselectRow(at: indexPath, animated: true)
       

       selectText = landmarks[indexPath.row]

       
       // 別の画面に遷移
       performSegue(withIdentifier: "toLandmarkViewController", sender: nil)
   }
   
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if (segue.identifier == "toLandmarkViewController") {
           let nextVC: LandmarkViewController = (segue.destination as? LandmarkViewController)!
           nextVC.landmarkText = selectText!
           //switch文も使用可能
       }
   }
   
}



