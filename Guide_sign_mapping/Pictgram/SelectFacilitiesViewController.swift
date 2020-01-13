import UIKit

class SelectFacilitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myTableView1: UITableView!
    var selectText:String?
    let Facilitiess: [[String]] = [[]]
    let Facilities: [String] = ["観光施設",
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
    
    let Facilities_en: [String] = ["Tourist facilities",
                                   "Toulist Information Center",
                                   "Parking",
                                   "Toilet",
                                   "Toilet(Whellchair Accessible)",
                                   "Post Office",
                                   "Hotel",
                                   "Bank",
                                   "Police Station/Box",
                                   "Firehouse",
                                   "School",
                                   "Railway Station/Streetcar Stop"]
    
    

    
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
        //cell.detailTextLabel?.numberOfLines = 0
        
        switch Facilities[indexPath.row]{
        case Facilities[0]:
            cell.imageView?.image = UIImage(named: "noimage.png")
        case Facilities[1]:
            cell.imageView?.image = UIImage(named: "noimage.png")
        case Facilities[2]:
            cell.imageView?.image = UIImage(named: "noimage.png")
        case Facilities[3]:
            cell.imageView?.image = UIImage(named: "noimage.png")
        case Facilities[4]:
            cell.imageView?.image = UIImage(named: "noimage.png")
        case Facilities[5]:
            cell.imageView?.image = UIImage(named: "noimage.png")
        case Facilities[6]:
            cell.imageView?.image = UIImage(named: "noimage.png")
        case Facilities[7]:
            cell.imageView?.image = UIImage(named: "noimage.png")
        case Facilities[8]:
            cell.imageView?.image = UIImage(named: "noimage.png")
        case Facilities[9]:
            cell.imageView?.image = UIImage(named: "noimage.png")
        case Facilities[10]:
            cell.imageView?.image = UIImage(named: "noimage.png")
        case Facilities[11]:
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

        if(Facilities[indexPath.row] == "観光施設"){
            performSegue(withIdentifier: "toSelectGenreViewController", sender: nil)
        }
        performSegue(withIdentifier: "toPictgramsViewController", sender: nil)
        
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
