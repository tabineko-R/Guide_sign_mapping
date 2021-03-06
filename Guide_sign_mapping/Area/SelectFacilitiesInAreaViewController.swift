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
    
    var selectText:String = ""
    var areaText:String = ""
    var areaText_ja:String = ""
    
    var All_num:Int = 1000
    var TF_num:Int = 1001
    //var TIC_num:Int = 1002
    var Parking_num:Int = 1003
    var Toilet_num:Int = 1004
    var WAToilet_num:Int = 1005
    
    let Facilities: [[String]] = [["エリア別表示","Area","Area"],
                                   ["観光施設","Tourist Facilities","Landmark"],
                                   ["観光案内所", "Toulist Information Center","TIC"],
                                   ["駐車場","Parking","Parking"],
                                   ["トイレ",  "Toilet","Toilet"],
                                   ["車いす対応トイレ", "Toilet(Whellchair Accessible)","WAToilet"],
                                   ["郵便局",  "Post Office","Post_Office"],
                                   ["ホテル",  "Hotel",  "Hotel"],
                                   ["金融機関", "Bank", "Bank"],
                                   ["警察署・交番", "Police Station/Box", "Police"],
                                   ["消防署","Firehouse","Firehouse"],
                                   ["学校", "School","School"],
                                   ["駅・電停",  "Railway Station/Streetcar Stop" ,"Station"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("エリア：\(areaText)")
        
        myTableView1 = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
        myTableView1.delegate = self
        myTableView1.dataSource = self
        myTableView1.estimatedRowHeight = 100
        myTableView1.rowHeight = UITableView.automaticDimension
        //self.view.addSubview(myTableView1)
        //navigation barのタイトル
        NB_title.title = areaText_ja
        
        switch areaText{
        case "Funami_park":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Funami_park.scn")!.rootNode
        case "Hakodate_mountain":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_mountain.scn")!.rootNode
        case "Hakodate_park":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_park.scn")!.rootNode
        case "Hakodate_station":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Hakodate_Station.scn")!.rootNode
        case "Motomachi_park":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Motomachi_park.scn")!.rootNode
        case "Nearby_facilities":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Nearby_Facilities.scn")!.rootNode
        case "Red_brick_warehouse":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Red_brick_warehouse.scn")!.rootNode
        case "Roopway_station":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Roopway_station.scn")!.rootNode
        case "Tachimachi_misaki":
            buttonNode = SCNScene(named: "art.scnassets/sign01/Tachimachi_misaki.scn")!.rootNode
        default:
            break
        }
        
        TF_num = (buttonNode.childNode(withName: "Landmark", recursively: false)?.childNodes.count ?? 0) - 1
        //TIC_num = buttonNode.childNode(withName: "Parking", recursively: false)?.childNode(withName: "pins", recursively: false)?.childNodes.count ?? 0
        Parking_num = buttonNode.childNode(withName: "Parking", recursively: false)?.childNode(withName: "pins", recursively: false)?.childNodes.count ?? 0
        Toilet_num = buttonNode.childNode(withName: "Toilet", recursively: false)?.childNode(withName: "pins", recursively: false)?.childNodes.count ?? 0
        WAToilet_num = buttonNode.childNode(withName: "WAToilet", recursively: false)?.childNode(withName: "pins", recursively: false)?.childNodes.count ?? 0
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
        
        cell.detailTextLabel?.text = Facilities[indexPath.row][1]
        //cell.detailTextLabel?.numberOfLines = 0
        
        if(Facilities[indexPath.row][0] == Facilities[0][0]){
            cell.imageView?.image = UIImage(named: Facilities[0][2])
                       cell.textLabel?.text = Facilities[indexPath.row][0] + " : \(All_num)施設あります"
                       if All_num == 0 {cell.textLabel?.text = Facilities[indexPath.row][0] + "エリア内に施設は存在しません"}
        }
        
        if(Facilities[indexPath.row][0] == Facilities[1][0]){
            cell.imageView?.image = UIImage(named: Facilities[0][2])
                       cell.textLabel?.text = Facilities[indexPath.row][0] + " : \(TF_num) 施設あります"
                       if  TF_num == 0 {cell.textLabel?.text = Facilities[indexPath.row][0] + " : エリア内に施設はありません"}
        }
        
        for i in 2 ..< Facilities.count{
            if(Facilities[indexPath.row][0] == Facilities[i][0]){
                cell.imageView?.image = UIImage(named: Facilities[i][2])
                cell.textLabel?.text = Facilities[i][0]
            }
        }
        
        return cell
    }
    
    //タップされた時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // タップされたセルの行番号を出力
        print("\(Facilities[indexPath.row])番目の行が選択されました。")
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        selectText = Facilities[indexPath.row][0]
        
        if Facilities[indexPath.row][0] == "観光施設" {
            performSegue(withIdentifier: "toSelectLandmarksInAreaVC", sender: nil)
        }else{
            performSegue(withIdentifier: "toFacilitiesVC", sender: nil)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toFacilitiesVC") {
            let nextVC: FacilitiesViewController = (segue.destination as? FacilitiesViewController)!
            nextVC.facilitiesText = selectText
            nextVC.areaText = areaText
        }else if (segue.identifier == "toSelectLandmarksInAreaVC") {
            let nextVC: SelectLandmarksInAreaViewController = (segue.destination as? SelectLandmarksInAreaViewController)!
            nextVC.facilitiesText = selectText
            nextVC.areaText = areaText
            nextVC.areaText_ja = areaText_ja
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
