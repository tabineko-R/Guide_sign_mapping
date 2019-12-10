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
        //公式ページがあったら
        details[4] = "ホームページ"
        
        switch landmarkText{
        case "旧ロシア領事館":
            overviewText = "幸坂の最高地点付近に建つレンガ造りの和洋折衷の建物。日本最初のロシア領事館として現在地で1906（明治39）年竣工。現在の建物は大火後の1908（明治41）年再建。景観形成指定建築物。"
            self.LandmarkImage.image = UIImage(named: "russian.jpg")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2009/04/post-68.html")!)
        case "太刀川家住宅（重要文化財）":
            overviewText = "明治34（1901）年、米穀商初代太刀川善吉が建築した土蔵造り2階建店舗。煉瓦積み漆喰塗りの不燃建築。国指定重要文化財。2019年6月から貸スペースとして活用されている。 "
            self.LandmarkImage.image = UIImage(named: "tachikawa.jpg")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-65.html")!)
        case "中華会館":
            overviewText = "1910（明治43）年築、関帝廟形式の集会場。内部の彫刻や装飾など、清朝末期の様式をよく伝える国内でも数少ない遺構。現在は、内部公開されていない。 "
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-58.html")!)
        case "新島襄海外渡航の地碑":
            overviewText = "後に同志社大学を創設する新島 襄が、国禁を犯してアメリカへ密航を企てたのが1864（元治元）年、その岸壁に記念碑が建てられている。 "
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2010/09/post-126.html")!)
        case "旧函館区公会堂（重要文化財）":
            overviewText = "1910（明治43）年築、工事費の大半が豪商相馬哲平の寄付による。基坂の真上にあり、バルコニーからの眺めは絶景。国指定重要文化財。大幅改修工事のため、2018年10月より休館。 "
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-59.html")!)
        case "旧北海道庁 函館支庁庁舎・旧開拓使書籍庫(観光案内所・写真歴史館)":
            overviewText = "元町公園内に建つこの洋風建築物は1909（明治42）年に建築され、1982（昭和57）年に修復整備された。前面の柱廊玄関のエンタシス風の柱が特徴。北海道有形文化財に指定。"
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-71.html")!)
        case "旧イギリス領事館（開港記念館）":
            overviewText = "1913（大正2）年築、1934年まで領事館として使用。1992年改装して開港記念館として一般開放。2009年、全面リニューアル。内部にはティールーム、英国雑貨店併設。"
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-54.html")!)
        case "ペリー提督来航記念碑":
            overviewText = "1854（安政元）年、函館が開港する契機となる米国のペリー提督率いる黒船5隻が函館に来航。その150周年を記念し、2002年、基坂沿いの元町公園下にペリーの立像が設置された。"
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2010/09/post-131.html")!)
        case "北方民族資料館":
            overviewText = "旧日本銀行函館支店の建物を活用した資料館で、アイヌ民族や北方民族の衣装、生活用品を展示。「ミシュラン・グリーンガイド・ジャポン2011」にて一つ星を獲得している。"
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2012/10/post-96.html")!)
        case "日本基督教団函館教会":
            overviewText = "1874（明治7）年、宣教師ハリスによって創設。現在の建物は1931（昭和6）年築。尖塔アーチの窓などゴシック様式デザインが特徴。設計は萩原惇正。景観形成指定建築物。"
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2010/04/post-61.html")!)
        case "郷土資料館（旧金森洋物店）":
            overviewText = "1880（明治13）年に建てられた「旧金森洋物店」を改修し、資料館として公開。和洋折衷の防火煉瓦造りで、明治時代の函館を今に伝えている。北海道指定有形文化財。"
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2012/10/post-99.html")!)
        case "金森美術館（バカラコレクション）":
            overviewText = " 2009年6月 閉館"
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "")!)
        case "北海道第一歩の地碑":
            overviewText = "明治以降北海道の玄関口となった函館の上陸地が東浜桟橋（旧桟橋）。ここに開道100年を記念して1968（昭和43）年に建立された記念碑。ヒグマと船のいかりがモチーフ。 "
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2010/09/post-127.html")!)
        case "遊覧船のりば":
            overviewText = "函館湾を一周する観光遊覧船。昼と夜、2つの顔を持つベイエリアを海の上から眺めることができる。船上で結婚パーティーや宴会の開催も可能（要予約）。"
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-fun/2010/10/post-80.html")!)
        case "北方歴史資料館":
            overviewText = "2013/04/01　完全閉館"
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "")!)
        case "函館高田屋嘉兵衛資料館":
            overviewText = "「箱館発展の恩人」と称される豪商・高田屋嘉兵衛は、私財を投じて箱館の基盤整備事業を実施し、造船所を建設した。その関連資料と北前船にまつわる資料が展示されている。 "
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2009/04/post-98.html")!)
        case "函館明治館（旧函館郵便局）":
            overviewText = "1911（明治44）年に函館郵便局として建てられた赤レンガの重厚な建造物。昭和58年から商業施設として民営化、現在はショッピングモールとして活用されている。 "
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-55.html")!)
        case "カトリック元町教会":
            overviewText = "最初の教会堂は1859（安政6）年創建。現在の建物は1923（大正12）年に再建。大聖堂内の祭壇はローマ教皇から贈られたもの。元町の代表的風景、教会群の一角を占める。 "
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-60.html")!)
        case "ハリストス正教会（重要文化財）":
            overviewText = "旧ロシア領事館"
            self.LandmarkImage.image = UIImage(named: "日本初のロシア正教会聖堂。白壁と緑屋根の対比が美しく、函館を代表する歴史的建造物。現存する聖堂は1916年築。週末などには美しい鐘の音色が響きわたる。 ")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-74.html")!)
        case "聖ヨハネ教会":
            overviewText = "1874年宣教が開始された英国聖公会（現、日本聖公会北海道教区）の教会。現在の建物は1979年築、茶色の十字形をした屋根が印象的。元町の有名な教会群の一角。"
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2011/04/post-75.html")!)
        case "東本願寺函館別院（重要文化財）":
            overviewText = "明治40年の大火で類焼、1915（大正4）年建替えに際して日本初の鉄筋コンクリート造りとした。ニ十間坂沿いに威風堂々と建つ。国指定重要文化財。東本願寺函館別院とも呼ばれる。 "
            self.LandmarkImage.image = UIImage(named: "noimage")
            safariVC = SFSafariViewController(url: URL(string: "https://www.hakobura.jp/db/db-view/2010/10/post-77.html")!)
        default:
            break
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
