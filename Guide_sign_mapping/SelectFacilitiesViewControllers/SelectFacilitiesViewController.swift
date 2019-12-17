import UIKit

class SelectFacilitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myTableView1: UITableView!
    var selectText:String?
    let Facilities: [String] = ["観光施設を探す",
                                "エリア別検索",
                                "周辺施設検索",
                                "観光案内所",
                                "駐車場",
                                "トイレ",
                                "車いす対応トイレ",
                                "郵便局",
                                "ホテル",
                                "金融機関",
                                "警察署・交番",
                                "消防署",
                                "学校",
                                "駅・電停"]
    
    let Facilities_en: [String] = ["Search Landmarks",
                                   "Search Area",
                                   "Search Near",
                                   "Information",
                                   "Parking",
                                   "Toilet",
                                   "Multipurpose Toilet",
                                   "郵便局",
                                   "Hotel",
                                   "金融機関",
                                   "警察署・交番",
                                   "消防署",
                                   "School",
                                   "Station"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView1 = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
        myTableView1.delegate = self
        myTableView1.dataSource = self
        myTableView1.estimatedRowHeight = 100
        myTableView1.rowHeight = UITableView.automaticDimension
        //self.view.addSubview(myTableView1)
    }
    
    //セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //セル数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Facilities.count
    }
    //セルを生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier: "aaa\(indexPath.section)-\(indexPath.row)")
        cell.textLabel?.text = Facilities[indexPath.row]
        cell.detailTextLabel?.text = Facilities_en[indexPath.row]
        cell.detailTextLabel?.numberOfLines = 0
        
        switch Facilities[indexPath.row]{
        case "観光案内所":
            cell.imageView?.image = UIImage(named: "noimage.png")
        case "駐車場":
            cell.imageView?.image = UIImage(named: "noimage.png")
        case "トイレ":
            cell.imageView?.image = UIImage(named: "noimage.png")
        case "車いす対応トイレ":
            cell.imageView?.image = UIImage(named: "noimage.png")
        case "郵便局":
            cell.imageView?.image = UIImage(named: "noimage.png")
        case "ホテル":
            cell.imageView?.image = UIImage(named: "noimage.png")
        case "金融機関":
            cell.imageView?.image = UIImage(named: "noimage.png")
        case "警察署・交番":
            cell.imageView?.image = UIImage(named: "noimage.png")
        case "消防署":
            cell.imageView?.image = UIImage(named: "noimage.png")
        case "学校":
            cell.imageView?.image = UIImage(named: "noimage.png")
        case "駅・電停":
            cell.imageView?.image = UIImage(named: "noimage.png")
        default:
            break
        }
        return cell
    }
    
    //タップされた時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // タップされたセルの行番号を出力
        print("\(Facilities[indexPath.row])番目の行が選択されました。")
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        selectText = Facilities[indexPath.row]
        // 別の画面に遷移
        if indexPath.row == 0 {
        performSegue(withIdentifier: "toSelectLandmarksVC", sender: nil)
        }else if indexPath.row == 1 {
        performSegue(withIdentifier: "toSearchAreaVC", sender: nil)
        }else if indexPath.row == 2 {
        performSegue(withIdentifier: "toSelectNearVC", sender: nil)
        }else{
        performSegue(withIdentifier: "toPictgramsViewController", sender: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toPictgramsViewController") {
            let nextVC: PictgramsViewController = (segue.destination as? PictgramsViewController)!
            nextVC.pictgramText = selectText!
            //switch文も使用可能
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
