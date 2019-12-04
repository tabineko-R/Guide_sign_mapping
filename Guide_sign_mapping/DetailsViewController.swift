//
//  ViewController.swift
//  Direction
//
//  Created by Shichimitoucarashi on 2017/12/15.
//  Copyright © 2017年 keisuke yamagishi. All rights reserved.
//

import UIKit

private var titleText = ""
private var overviewText = ""

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var LandmarkImage: UIImageView!
    
    var details: [String] = [titleText, overviewText, ""]
    var landmarkText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.estimatedRowHeight = 100
        detailsTableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.numberOfLines=0
        
        
        switch landmarkText{
        case "旧ロシア領事館":
            overviewText = "いぬぬわん"
            self.LandmarkImage.image = UIImage(named: "russian.jpg")
        case "太刀川家住宅（重要文化財）":
            overviewText = "わんぱち"
            self.LandmarkImage.image = UIImage(named: "tachikawa.jpg")
        default:
            break
        }
        
        details = ["名称 : " + landmarkText,"概要 : \n" + overviewText, "はこぶらで詳細を見る"]
        cell.textLabel!.text = details[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 2 {
            performSegue(withIdentifier: "toDirections", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDirections") {
            let nextVC: DirectionsViewController = (segue.destination as? DirectionsViewController)!
            nextVC.landmarkText = landmarkText
        }
    }
    
}
