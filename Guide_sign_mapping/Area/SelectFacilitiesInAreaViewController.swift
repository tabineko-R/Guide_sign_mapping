//
//  SelectFacilitiesInAreaViewController.swift
//  Guide_sign_mapping
//
//  Created by yuya on 2019/12/17.
//  Copyright © 2019 yuya. All rights reserved.
//

import UIKit
import ARKit

class SelectFacilitiesInAreaViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var myTableView1: UITableView!
    @IBOutlet weak var NB_title: UINavigationItem!
    
    private var buttonNode: SCNNode!
    
    var selectText:String?
    var areaText:String?
    
    var All_num:Int = 1000
    var TF_num:Int = 1001
    //var TIC_num:Int = 1002
    var Parking_num:Int = 1003
    var Toilet_num:Int = 1004
    var WAToilet_num:Int = 1005
    var list:[SCNNode] = []

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
                                   "Tourist Facilities",
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
        //navigation barのタイトル
        NB_title.title = areaText
        
        switch areaText{
        case "船見公園周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_park.scn")!.rootNode
        case "函館山周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_park.scn")!.rootNode
        case "函館公園周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_park.scn")!.rootNode
        case "函館駅周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_Station.scn")!.rootNode
        case "元町公園周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Motomachi_park.scn")!.rootNode
        case "周辺施設":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Nearby_Facilities.scn")!.rootNode
        case "赤レンガ倉庫周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Red_brick_warehouse.scn")!.rootNode
        case "ロープウェイ山麓駅周辺":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Roopway_station.scn")!.rootNode
        case "立待岬":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Roopway_station.scn")!.rootNode
        default:
            break
        }
    
         TF_num = buttonNode.childNode(withName: "Landmark", recursively: false)?.childNodes.count ?? 0
         //TIC_num = buttonNode.childNode(withName: "Parking", recursively: false)?.childNode(withName: "pins", recursively: false)?.childNodes.count ?? 0
         Parking_num = buttonNode.childNode(withName: "Parking", recursively: false)?.childNode(withName: "pins", recursively: false)?.childNodes.count ?? 0
         Toilet_num = buttonNode.childNode(withName: "Toilet", recursively: false)?.childNode(withName: "pins", recursively: false)?.childNodes.count ?? 0
         WAToilet_num = buttonNode.childNode(withName: "WAToilet", recursively: false)?.childNode(withName: "pins", recursively: false)?.childNodes.count ?? 0
        
        
        list = buttonNode.childNode(withName: "Landmark", recursively: false)?.childNodes ?? []
        
        
        //....//
        
         All_num = TF_num + Parking_num + Toilet_num + WAToilet_num
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
        
        cell.detailTextLabel?.text = Facilities_en[indexPath.row]
        //cell.detailTextLabel?.numberOfLines = 0
        
        switch Facilities[indexPath.row]{
        case "すべて表示する":
            cell.imageView?.image = UIImage(named: "noimage.png")
            cell.textLabel?.text = Facilities[indexPath.row] + " : \(All_num)施設あります"
            if All_num == 0 {cell.textLabel?.text = Facilities[indexPath.row] + "エリア内に施設は存在しません"}
        case "観光施設":
            cell.imageView?.image = UIImage(named: "noimage.png")
            cell.textLabel?.text = Facilities[indexPath.row] + " : \(TF_num) 施設あります"
            if  TF_num == 0 {cell.textLabel?.text = Facilities[indexPath.row] + " : エリア内に施設はありません"}
        case "観光案内所":
            cell.imageView?.image = UIImage(named: "noimage.png")
            cell.textLabel?.text = Facilities[indexPath.row]
        case "駐車場":
            cell.imageView?.image = UIImage(named: "noimage.png")
            cell.textLabel?.text = Facilities[indexPath.row] + " : \(Parking_num) 施設あります"
        case "トイレ":
            cell.imageView?.image = UIImage(named: "noimage.png")
            cell.textLabel?.text = Facilities[indexPath.row] + " : \(Toilet_num) 施設あります"
        case "車いす対応トイレ":
            cell.imageView?.image = UIImage(named: "noimage.png")
            cell.textLabel?.text = Facilities[indexPath.row] + " : \(WAToilet_num) 施設あります"
        case "郵便局":
            cell.imageView?.image = UIImage(named: "noimage.png")
      cell.textLabel?.text = Facilities[indexPath.row]
        case "ホテル":
            cell.imageView?.image = UIImage(named: "noimage.png")
  cell.textLabel?.text = Facilities[indexPath.row]
        case "金融機関":
            cell.imageView?.image = UIImage(named: "noimage.png")
cell.textLabel?.text = Facilities[indexPath.row]
        case "警察署・交番":
            cell.imageView?.image = UIImage(named: "noimage.png")
    cell.textLabel?.text = Facilities[indexPath.row]
        case "消防署":
            cell.imageView?.image = UIImage(named: "noimage.png")
    cell.textLabel?.text = Facilities[indexPath.row]
        case "学校":
            cell.imageView?.image = UIImage(named: "noimage.png")
 cell.textLabel?.text = Facilities[indexPath.row]
        case "駅・電停":
            cell.imageView?.image = UIImage(named: "noimage.png")
cell.textLabel?.text = Facilities[indexPath.row]
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
        
        if Facilities[indexPath.row] == "観光施設" {
        performSegue(withIdentifier: "toSelectLandmarksInAreaVC", sender: nil)
        }else{
        performSegue(withIdentifier: "toFacilitiesVC", sender: nil)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toFacilitiesVC") {
            let nextVC: FacilitiesViewController = (segue.destination as? FacilitiesViewController)!
            nextVC.facilitiesText = selectText!
            nextVC.areaText = areaText!
            //switch文も使用可能
        }else if (segue.identifier == "toSelectLandmarksInAreaVC") {
            let nextVC: SelectLandmarksInAreaViewController = (segue.destination as? SelectLandmarksInAreaViewController)!
            nextVC.areaText = areaText!
            //switch文も使用可能
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
