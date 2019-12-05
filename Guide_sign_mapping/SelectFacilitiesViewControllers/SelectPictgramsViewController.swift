import UIKit

class SelectPictgramViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myTableView1: UITableView!
    let pictgrams: [String] = ["観光案内所",
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
    
    let pictgrams_detail: [String] = ["Information",
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
    
    //④セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //④セクションタイトルを指定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "第\(section)セクション"
    }
    //④セル数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictgrams.count
    }
    //④セルを生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier: "aaa\(indexPath.section)-\(indexPath.row)")
        cell.textLabel?.text = pictgrams[indexPath.row]
        cell.detailTextLabel?.text = pictgrams_detail[indexPath.row]
        cell.detailTextLabel?.numberOfLines = 0
        
        switch pictgrams[indexPath.row]{
        case "観光案内所":
            cell.imageView?.image = UIImage(named: "information.png")
        case "駐車場":
            cell.imageView?.image = UIImage(named: "parking.png")
        case "トイレ":
            cell.imageView?.image = UIImage(named: "toilet.png")
        case "車いす対応トイレ":
            cell.imageView?.image = UIImage(named: "multiporpose_toilet.png")
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}