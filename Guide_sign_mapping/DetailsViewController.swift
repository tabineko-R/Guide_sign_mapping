//
//  ViewController.swift
//  Direction
//
//  Created by Shichimitoucarashi on 2017/12/15.
//  Copyright © 2017年 keisuke yamagishi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController{
    
    var landmarkText:String = ""
    var detailText:String = ""
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var detail: UILabel!
    
    @IBOutlet weak var textArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*self.imgView.frame = CGRect(x: 50, y: 150, width: 200, height: 200)
         self.imgView.image = UIImage(named: "sample2.png")*/
        // 角を丸くする
        self.imgView.layer.cornerRadius = 300 * 0.5
        self.imgView.clipsToBounds = true
        self.view.addSubview(self.imgView)
        
        // ①storyboardのインスタンス取得
        //let storyboard: UIStoryboard = self.storyboard!
        // ②遷移先ViewControllerのインスタンス取得(identifierの名前を間違うとフリーズ起こす)
        //let toDirections = storyboard.instantiateViewController(withIdentifier: "directions") as! DirectionsViewController
        
        //toDirections.landmarkText = landmarkText
        
        print(landmarkText)
        
        switch landmarkText{
        case "旧ロシア領事館":
            detail.text = landmarkText
            textArea.text = "幸坂の最高地点付近に建つレンガ造りの和洋折衷の建物。日本最初のロシア領事館として現在地で1906（明治39）年竣工。現在の建物は大火後の1908（明治41）年再建。景観形成指定建築物。"
            self.imgView.image = UIImage(named: "russian.jpg")
        case "太刀川家住宅（重要文化財）":
            detail.text = landmarkText
            textArea.text = "明治34（1901）年、米穀商初代太刀川善吉が建築した土蔵造り2階建店舗。煉瓦積み漆喰塗りの不燃建築。国指定重要文化財。2019年6月から貸スペースとして活用されている。"
            self.imgView.image = UIImage(named: "tachikawa.jpg")
        case "中草会館":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "新島襄海外渡航の地碑":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "旧函館区公会堂（重要文化財）":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "旧北海道庁 函館支庁庁舎・旧":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "旧開拓使書籍庫":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "旧イギリス領事館（開港記念館）":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "ペリー提督来航記念碑":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "北方民族資料間":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "日本基督教団函館教会":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "郷土資料館（旧金森洋物店）":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "金森美術館（バカラコレクション）":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "北海道第一歩の地碑":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "遊覧船のりば":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "北方歴史資料間":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "函館高田屋嘉兵衛資料館":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "函館明治館（旧函館郵便局）":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "カトリック元町教会":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "ハリストス正教会（重要文化財）":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "聖ヨハネ教会":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        case "東本願寺函館別院（重要文化財）":
            detail.text = landmarkText
            textArea.text = landmarkText + "です。"
        default:
            break
        }
        
        // ①storyboardのインスタンス取得
        let storyboard: UIStoryboard = self.storyboard!
        // ②遷移先ViewControllerのインスタンス取得(identifierの名前を間違うとフリーズ起こす)
        let toDetails = storyboard.instantiateViewController(withIdentifier: "directions") as! DirectionsViewController
        
        toDetails.landmarkText = landmarkText
        self.present(toDetails, animated: true, completion: nil)
        
    }
    
    // ①セグエ実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDirections") {
            let nextVC: DirectionsViewController = (segue.destination as? DirectionsViewController)!
            nextVC.landmarkText = landmarkText
            //switch文も使用可能
        }
    }
}


