//
//  ViewController.swift
//  Direction
//
//  Created by Shichimitoucarashi on 2017/12/15.
//  Copyright © 2017年 keisuke yamagishi. All rights reserved.
//

import UIKit
import SafariServices

private var titleText = ""
private var overviewText = ""
private var safariVC = SFSafariViewController(url: URL(string: "https://www.google.com/")!)

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var LandmarkImage: UIImageView!
    
    var details: [String] = [titleText, overviewText, "", ""]
    var landmarkText:String = ""
    var pictgramText:String = ""
    
    let Landmarks: [[String]] = [["遊覧船のりば","",""],
                                    ["函館明治館（旧函館郵便局）","","meiji"],
                                    ["中華会館","",""],
                                    ["金森美術館（バカラコレクション）","",""],
                                    ["旧北海道庁 函館支庁庁舎・旧開拓使書籍庫(観光案内所・写真歴史館)","",""],
                                    ["旧ロシア領事館","",""],
                                    ["旧イギリス領事館（開港記念館）","",""],
                                    ["太刀川家住宅（重要文化財）","",""],
                                    ["旧函館区公会堂（重要文化財）","",""],
                                    ["ハリストス正教会（重要文化財）","",""],
                                    ["東本願寺函館別院（重要文化財）","",""],
                                    ["日本基督教団函館教会","",""],
                                    ["カトリック元町教会","",""],
                                    ["聖ヨハネ教会","",""],
                                    ["新島襄海外渡航の地碑","",""],
                                    ["北海道第一歩の地碑","",""],
                                    ["ペリー提督来航記念碑","",""],
                                    ["北方歴史資料館","","hoppou"],
                                    ["函館高田屋嘉兵衛資料館","",""],
                                    ["北方民族資料館","",""],
                                    ["郷土資料館（旧金森洋物店）","",""],
                                    ["函館市文学館","",""]]
    
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
        
        //セルの高さを自動設定
        cell.textLabel?.numberOfLines=0
        
        details = ["名称 : " + landmarkText,"概要 : \n" + overviewText, "地図で確認する", "はこぶらで詳細を見る", ""]
       
        /*
        for i in 0 ..< Landmarks.count{
            if(landmarkText == Landmarks[i][0]){
                self.LandmarkImage.image = UIImage(named: Landmarks[i][2])
                overviewText = Landmarks[i][3]
                safariVC = SFSafariViewController(url: URL(string: Landmarks[i][4])!)
            }else{
         details[3] = "ホームページ
         }
            //公式ページがあったら
            if(Landmarks[i][0] == "1"){details[4] = "ホームページ"}
        }
 */
        
        switch landmarkText{
        case "旧ロシア領事館":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "russian.jpg")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2009/04/post-68.html")!)
        case "太刀川家住宅（重要文化財）":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "tachikawa.jpg")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-65.html")!)
        case "中華会館":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-58.html")!)
        case "新島襄海外渡航の地碑":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2010/09/post-126.html")!)
        case "旧函館区公会堂（重要文化財）":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-59.html")!)
        case "旧北海道庁 函館支庁庁舎・旧開拓使書籍庫(観光案内所・写真歴史館)":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-71.html")!)
        case "旧イギリス領事館（開港記念館）":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-54.html")!)
        case "ペリー提督来航記念碑":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2010/09/post-131.html")!)
        case "北方民族資料館":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "hoppou")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2012/10/post-96.html")!)
        case "日本基督教団函館教会":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2010/04/post-61.html")!)
        case "郷土資料館（旧金森洋物店）":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2012/10/post-99.html")!)
        case "金森美術館（バカラコレクション）":
            overviewText = " 2009年6月 閉館"
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "")!)
        case "北海道第一歩の地碑":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2010/09/post-127.html")!)
        case "遊覧船のりば":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-fun/2010/10/post-80.html")!)
        case "北方歴史資料館":
            overviewText = "2013/04/01　完全閉館"
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "")!)
        case "函館高田屋嘉兵衛資料館":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2009/04/post-98.html")!)
        case "函館明治館（旧函館郵便局）":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "meiji")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-55.html")!)
        case "カトリック元町教会":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-60.html")!)
        case "ハリストス正教会（重要文化財）":
            overviewText = "旧ロシア領事館"
            self.LandmarkImage.image = UIImage(named: "")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-74.html")!)
        case "聖ヨハネ教会":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-75.html")!)
        case "東本願寺函館別院（重要文化財）":
            overviewText = ""
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2010/10/post-77.html")!)
        default:
            overviewText = "未設定"
            self.LandmarkImage.image = UIImage(named: landmarkText)
            safariVC = SFSafariViewController(url: URL(string: "https://www.google.com")!)
        }

        
        cell.textLabel!.text = details[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 2:
            performSegue(withIdentifier: "toDirections", sender: nil)
        case 3:
            self.present(safariVC, animated: true, completion: nil)
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDirections") {
            let nextVC: DirectionsViewController = (segue.destination as? DirectionsViewController)!
            nextVC.landmarkText = landmarkText
        }
    }
    
}
