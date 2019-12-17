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
    
    
    var selectText:String?
    var Facilities: [String] = ["",
                                "",
                                "",
                                "",
                                ""]
    
    var Facilities_en: [String] = ["",
                                   "",
                                   "",
                                   "",
                                   ""]
    
    
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
        
        switch selectText{
        case "函館公園周辺":
            Facilities = ["函館公園周辺01",
                          "函館公園周辺02",
                          "函館公園周辺03",
                          "函館公園周辺04",
                          "函館公園周辺05"]
        case "ロープウェイ山麓駅周辺":
            Facilities = ["ロープウェイ山麓駅周辺01",
                          "ロープウェイ山麓駅周辺02",
                          "ロープウェイ山麓駅周辺03",
                          "ロープウェイ山麓駅周辺04",
                          "ロープウェイ山麓駅周辺05"]
        case "元町公園周辺":
            Facilities = ["元町公園周辺01",
                          "元町公園周辺02",
                          "元町公園周辺03",
                          "元町公園周辺04",
                          "元町公園周辺05"]
        case "赤レンガ倉庫周辺":
            Facilities = ["レンガ倉庫周辺01",
                          "レンガ倉庫周02",
                          "レンガ倉庫周辺03",
                          "レンガ倉庫周辺04",
                          "レンガ倉庫周辺05"]
        case "函館駅周辺":
            Facilities = ["函館駅周辺01",
                          "函館駅周辺02",
                          "函館駅周辺03",
                          "函館駅周辺04",
                          "函館駅周辺05"]
            
        default:
            break
        }
        
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
