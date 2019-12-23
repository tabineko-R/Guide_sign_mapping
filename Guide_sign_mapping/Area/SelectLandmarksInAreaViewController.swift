import UIKit

class SelectLandmarksInAreaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet var TableView: UITableView!
    
    @IBOutlet weak var NB_title: UINavigationItem!
    //prepareで使うためのワンクッション
   var selectText:String?
    var areaText:String?
   
   //配列landmarksを設定
    var Genres:[String] = [
    "歴史的建造物（一般入場可能）",
   "歴史的建造物（外観見学のみ）",
   "教会・寺院",
   "資料館",
   "記念碑",
   "体験・アクティビティー",
   "閉館"]
    
        var Landmarks_num:[Int] = []
   
   //    //landmarksと数を一致させる let photos = ["russian","tachikawa","","","",""]
   
   
   
   
   override func viewDidLoad() {
       super.viewDidLoad()
       
       TableView = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
       TableView.delegate = self
       TableView.dataSource = self
       TableView.estimatedRowHeight = 100
       TableView.rowHeight = UITableView.automaticDimension
    
    NB_title.title = areaText
    
    switch areaText{
    case "船見公園周辺":
        Landmarks_num = [0,3,0,0,1,0,0]
    case "函館山周辺":
        Landmarks_num = [0,0,0,0,0,0,0]
    case "函館公園周辺":
        Landmarks_num = [0,0,0,0,0,0,0]
    case "函館駅周辺":
        Landmarks_num = [0,0,0,0,0,0,0]
    case "元町公園周辺":
         Landmarks_num = [2,3,5,5,3,1,1]
    case "周辺施設":
         Landmarks_num = [2,0,5,5,1,1,1]
    case "赤レンガ倉庫周辺":
        Landmarks_num = [2,1,2,5,3,1,1]
    case "ロープウェイ山麓駅周辺":
        Landmarks_num = [0,0,5,3,0,1,1]
    case "立待岬":
        Landmarks_num = [0,0,0,0,0,0,0]
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
       return Genres.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       // セルを取得する
       let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                  reuseIdentifier:"cell")
       
       switch indexPath.section {
       case 0:
           // セルに表示する値を設定する
           cell.textLabel!.text = Genres[indexPath.row] + " : " + String(Landmarks_num[indexPath.row]) + "施設あります"
           
           if Landmarks_num[indexPath.row] == 0{
           cell.textLabel!.text = Genres[indexPath.row] + " : 施設はありません"
           }
           //cell.imageView?.image = UIImage(named: photos[indexPath.row])
           
       default:
           break
       }
       
       return cell
   }
   
   //タップされた時
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       // タップされたセルの行番号を出力
       print("\(Genres[indexPath.row])番目の行が選択されました。")
       // セルの選択を解除
       tableView.deselectRow(at: indexPath, animated: true)
       

       selectText = Genres[indexPath.row]

       
       // 別の画面に遷移
       performSegue(withIdentifier: "toSLIGIAVC", sender: nil)
   }
   
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if (segue.identifier == "toSLIGIAVC") {
           let nextVC: SelectLandmarkInGenreInAreaViewController = (segue.destination as? SelectLandmarkInGenreInAreaViewController)!
           nextVC.genreText = selectText!
        nextVC.areaText = areaText!
           //switch文も使用可能
       }
   }
   
}



