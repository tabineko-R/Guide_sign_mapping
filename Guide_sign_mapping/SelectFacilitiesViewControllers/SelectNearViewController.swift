

import UIKit

class SelectNearViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var myTableView1: UITableView!
    
        var selectText:String?
        let Facilities: [String] = ["周辺施設01",
                                    "周辺施設02",
                                    "周辺施設03",
                                    "周辺施設04",
                                    "周辺施設05"]
        
        let Facilities_en: [String] = ["Near01",
                                       "Near02",
                                       "Near03",
                                       "Near04",
                                       "Near05"]
        
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
            case "函館公園周辺":
                cell.imageView?.image = UIImage(named: "information.png")
            case "ロープウェイ山麓駅周辺":
                cell.imageView?.image = UIImage(named: "parking.png")
            case "元町公園周辺":
                cell.imageView?.image = UIImage(named: "toilet.png")
            case "赤レンガ倉庫周辺":
                cell.imageView?.image = UIImage(named: "multiporpose_toilet.png")
            case "函館駅周辺":
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

            performSegue(withIdentifier: "toFacilitiesVC", sender: nil)
            
        }
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "toFacilitiesVC") {
                let nextVC: FacilitiesViewController = (segue.destination as? FacilitiesViewController)!
                nextVC.facilitiesText = selectText!
                //switch文も使用可能
            }
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


