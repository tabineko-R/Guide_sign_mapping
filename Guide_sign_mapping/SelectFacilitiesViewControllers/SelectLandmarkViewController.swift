import UIKit

class SelectLandmarkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var TableView: UITableView!
    //prepareで使うためのワンクッション
    var selectText:String?
    
    //配列landmarksを設定
    var landmarks = ["遊覧船のりば",
                     "函館明治館（旧函館郵便局）",
                     "中華会館",
                     "金森美術館（バカラコレクション）",
                     "旧北海道庁 函館支庁庁舎・旧開拓使書籍庫(観光案内所・写真歴史館)",
                     "旧ロシア領事館",
                     "旧イギリス領事館（開港記念館）",
                     "太刀川家住宅（重要文化財）",
                     "旧函館区公会堂（重要文化財）",
                     "ハリストス正教会（重要文化財）",
                     "東本願寺函館別院（重要文化財）",
                     "日本基督教団函館教会",
                     "カトリック元町教会",
                     "聖ヨハネ教会",
                     "新島襄海外渡航の地碑",
                     "北海道第一歩の地碑",
                     "ペリー提督来航記念碑",
                     "北方歴史資料館",
                     "函館高田屋嘉兵衛資料館",
                     "北方民族資料館",
                     "郷土資料館（旧金森洋物店）",
                     "函館市文学館"]
    
    //    //landmarksと数を一致させる let photos = ["russian","tachikawa","","","",""]
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
        TableView.delegate = self
        TableView.dataSource = self
        TableView.estimatedRowHeight = 100
        TableView.rowHeight = UITableView.automaticDimension
    }
    
    //セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
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
        
        switch indexPath.section {
         case 0:
        selectText = landmarks[indexPath.row]
         default:
             break
         }
        
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

/*
 
 class SelectLandmarkViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource{
 
 var TableView2: UITableView!
 
 var selectText:String?
 //配列landmarksを設定
 let landmarks2 = [
 "ペリー提督来航記念碑",
 "北方民族資料間",
 "日本基督教団函館教会",
 "郷土資料館（旧金森洋物店）",
 "金森美術館（バカラコレクション）",
 "北海道第一歩の地碑",
 "遊覧船のりば",
 "北方歴史資料間",
 "函館高田屋嘉兵衛資料館",
 "函館明治館（旧函館郵便局）",
 "カトリック元町教会",
 "ハリストス正教会（重要文化財）",
 "聖ヨハネ教会",
 "東本願寺函館別院（重要文化財）"]
 
 override func viewDidLoad() {
 super.viewDidLoad()
 TableView2 = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
 TableView2.delegate = self
 TableView2.dataSource = self
 TableView2.estimatedRowHeight = 100
 TableView2.rowHeight = UITableView.automaticDimension
 }
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return landmarks2.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 // セルを取得する
 let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
 reuseIdentifier:"cell")
 // セルに表示する値を設定する
 cell.textLabel!.text = landmarks2[indexPath.row]
 
 return cell
 }
 
 //タップされた時
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 // タップされたセルの行番号を出力
 print("\(landmarks2[indexPath.row])番目の行が選択されました。")
 // セルの選択を解除
 tableView.deselectRow(at: indexPath, animated: true)
 selectText = landmarks2[indexPath.row]
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
 */
