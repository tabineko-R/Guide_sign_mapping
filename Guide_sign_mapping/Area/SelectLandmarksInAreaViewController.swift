import UIKit

class SelectLandmarksInAreaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var TableView: UITableView!
    
    @IBOutlet weak var NB_title: UINavigationItem!
    //prepareで使うためのワンクッション
    var selectText:String = ""
    var areaText:String = ""
    var areaText_ja:String = ""
    var facilitiesText:String = ""
    
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
    
    //landmarksと数を一致させる let photos = ["russian","tachikawa","","","",""]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
        TableView.delegate = self
        TableView.dataSource = self
        TableView.estimatedRowHeight = 100
        TableView.rowHeight = UITableView.automaticDimension
        
        NB_title.title = "観光施設(\(areaText_ja))"
        
        switch areaText{
        case "Funami_park":
            Landmarks_num = [0,3,0,0,1,0,0]
        case "Hakodate_mountain":
            Landmarks_num = [0,0,0,0,0,0,0]
        case "Hakodate_park":
            Landmarks_num = [0,0,0,0,0,0,0]
        case "Hakodate_station":
            Landmarks_num = [0,0,0,0,0,0,0]
        case "Motomachi_park":
            Landmarks_num = [2,3,5,5,3,1,1]
        case "Nearby_facilities":
            Landmarks_num = [2,0,5,5,1,1,1]
        case "Red_brick_warehouse":
            Landmarks_num = [2,1,2,5,3,1,1]
        case "Roopway_station":
            Landmarks_num = [0,0,5,3,0,1,1]
        case "Tachimachi_misaki":
            Landmarks_num = [0,0,0,0,0,0,0]
        default:
            Landmarks_num = [99,99,99,99,99,99,99]
        }
        
    }
    
    //セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier:"cell")
        // セルに表示する値を設定する
        cell.textLabel!.text = Genres[indexPath.row] + " : " + String(Landmarks_num[indexPath.row]) + "施設あります"
        if Landmarks_num[indexPath.row] == 0{
            cell.textLabel!.text = Genres[indexPath.row] + " : 施設はありません"
        }
        //cell.imageView?.image = UIImage(named: photos[indexPath.row])
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
            nextVC.genreText = selectText
            nextVC.areaText = areaText
            nextVC.facilitiesText = facilitiesText
            //switch文も使用可能
        }
    }
}
