//
//  SelectFacilitiesInAreaViewController.swift
//  Guide_sign_mapping
//
//  Created by yuya on 2019/12/17.
//  Copyright © 2019 yuya. All rights reserved.
//

import UIKit

class SelectFacilitiesInAreaViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var myTableView1: UITableView!
    @IBOutlet weak var NB_title: UINavigationItem!

    
    var selectText:String?
    var areaText:String?
    
    let Facilities: [String] = ["すべて表示する",
                                "観光施設",
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
    
    let Facilities_en: [String] = ["Show All",
                                   "Tourist facilities",
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
        NB_title.title = selectText
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
        
        performSegue(withIdentifier: "toFacilitiesVC", sender: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toFacilitiesVC") {
            let nextVC: FacilitiesViewController = (segue.destination as? FacilitiesViewController)!
            nextVC.facilitiesText = selectText!
            nextVC.areaText = areaText!
            //switch文も使用可能
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
