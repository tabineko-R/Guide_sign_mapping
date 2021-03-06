import UIKit

class SelectLandmarkInGenreInAreaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var TableView: UITableView!
    @IBOutlet weak var NB_title: UINavigationItem!
    //prepareで使うためのワンクッション
    var selectText:String = ""
    
    //前のVCの値
    var areaText:String = ""
    var genreText:String = ""
    var facilitiesText:String = ""
    var landmarkText:String = ""
    var photos:[String] = []
    
    //配列landmarksを設定
    var landmarks: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
        TableView.delegate = self
        TableView.dataSource = self
        TableView.estimatedRowHeight = 100
        TableView.rowHeight = UITableView.automaticDimension
        
        NB_title.title = "\(genreText)"
        
        switch areaText {
        case "Nearby_Facilities":
            switch genreText {
            case "歴史的建造物（一般入場可能）":
                landmarks = [
                    "函館明治館（旧函館郵便局）",
                    "旧イギリス領事館（開港記念館）"]
                photos = ["meiji_kan",""]
            case "歴史的建造物（外観見学のみ）":
                landmarks = []
            case "教会・寺院":
                landmarks = [
                    "ハリストス正教会（重要文化財）",
                    "東本願寺函館別院（重要文化財）",
                    "日本基督教団函館教会",
                    "カトリック元町教会",
                    "聖ヨハネ教会"]
            case "資料館":
                landmarks = [
                    "北方歴史資料館",
                    "函館高田屋嘉兵衛資料館",
                    "北方民族資料館",
                    "郷土資料館（旧金森洋物店）",
                    "函館市文学館"]
            case "記念碑":
                landmarks = ["北海道第一歩の地碑",]
            case "体験・アクティビティー":
                landmarks = ["遊覧船のりば"]
            case "閉館":
                landmarks = ["金森美術館（バカラコレクション）"]
            default:
                break
            }
            
        case "Hakodate_park":
            switch genreText {
            case "歴史的建造物（一般入場可能）":
                landmarks = []
            case "歴史的建造物（外観見学のみ）":
                landmarks = []
            case "教会・寺院":
                landmarks = []
            case "資料館":
                landmarks = []
            case "記念碑":
                landmarks = []
            case "体験・アクティビティー":
                landmarks = []
            case "閉館":
                landmarks = []
            default:
                break
            }
            
        case "ロープウェイ山麓駅周辺":
            switch genreText {
            case "歴史的建造物（一般入場可能）":
                landmarks = []
            case "歴史的建造物（外観見学のみ）":
                landmarks = []
            case "教会・寺院":
                landmarks = [
                    "ハリストス正教会（重要文化財）",
                    "東本願寺函館別院（重要文化財）",
                    "日本基督教団函館教会",
                    "カトリック元町教会",
                    "聖ヨハネ教会"]
            case "資料館":
                landmarks = [
                    "北方歴史資料館",
                    "郷土資料館（旧金森洋物店）",
                    "函館市文学館"]
            case "記念碑":
                landmarks = []
            case "体験・アクティビティー":
                landmarks = ["遊覧船のりば"]
            case "閉館":
                landmarks = ["金森美術館（バカラコレクション）"]
            default:
                break
            }
            
            
        case "Motomachi_park":
            switch genreText {
            case "歴史的建造物（一般入場可能）":
                landmarks = [
                    "旧北海道庁 函館支庁庁舎・旧開拓使書籍庫(観光案内所・写真歴史館)",
                    "旧イギリス領事館（開港記念館）"]
            case "歴史的建造物（外観見学のみ）":
                landmarks = [
                    "中華会館",
                    "太刀川家住宅（重要文化財）",
                    "旧函館区公会堂（重要文化財）"]
            case "教会・寺院":
                landmarks = [
                    "ハリストス正教会（重要文化財）",
                    "東本願寺函館別院（重要文化財）",
                    "日本基督教団函館教会",
                    "カトリック元町教会",
                    "聖ヨハネ教会"]
            case "資料館":
                landmarks = [
                    "北方歴史資料館",
                    "函館高田屋嘉兵衛資料館",
                    "北方民族資料館",
                    "郷土資料館（旧金森洋物店）",
                    "函館市文学館"]
            case "記念碑":
                landmarks = [
                    "新島襄海外渡航の地碑",
                    "北海道第一歩の地碑",
                    "ペリー提督来航記念碑"]
            case "体験・アクティビティー":
                landmarks = ["遊覧船のりば"]
            case "閉館":
                landmarks = ["金森美術館（バカラコレクション）"]
            default:
                break
            }
            
        case "Red_brick_warehouse":
            switch genreText {
            case "歴史的建造物（一般入場可能）":
                landmarks = [
                    "函館明治館（旧函館郵便局）",
                    "旧イギリス領事館（開港記念館）"]
            case "歴史的建造物（外観見学のみ）":
                landmarks = ["中華会館"]
            case "教会・寺院":
                landmarks = [
                    "東本願寺函館別院（重要文化財）",
                    "日本基督教団函館教会"]
            case "資料館":
                landmarks = [
                    "北方歴史資料館",
                    "函館高田屋嘉兵衛資料館",
                    "北方民族資料館",
                    "郷土資料館（旧金森洋物店）",
                    "函館市文学館"]
            case "記念碑":
                landmarks = [
                    "新島襄海外渡航の地碑",
                    "北海道第一歩の地碑",
                    "ペリー提督来航記念碑"]
            case "体験・アクティビティー":
                landmarks = ["遊覧船のりば"]
            case "閉館":
                landmarks = ["金森美術館（バカラコレクション）"]
            default:
                break
            }
            
            
        case "Hakodate_station":
            switch genreText {
            case "歴史的建造物（一般入場可能）":
                landmarks = []
            case "歴史的建造物（外観見学のみ）":
                landmarks = []
            case "教会・寺院":
                landmarks = []
            case "資料館":
                landmarks = []
            case "記念碑":
                landmarks = []
            case "体験・アクティビティー":
                landmarks = []
            case "閉館":
                landmarks = []
            default:
                break
            }
            
        case "Hakodate_mountain":
            switch genreText {
            case "歴史的建造物（一般入場可能）":
                landmarks = []
            case "歴史的建造物（外観見学のみ）":
                landmarks = []
            case "教会・寺院":
                landmarks = []
            case "資料館":
                landmarks = []
            case "記念碑":
                landmarks = []
            case "体験・アクティビティー":
                landmarks = []
            case "閉館":
                landmarks = []
            default:
                break
            }
            
        case "Funami_park":
            switch genreText {
            case "歴史的建造物（一般入場可能）":
                landmarks = []
            case "歴史的建造物（外観見学のみ）":
                landmarks = [
                    "中華会館",
                    "旧ロシア領事館",
                    "太刀川家住宅（重要文化財）",
                ]
            case "教会・寺院":
                landmarks = []
            case "資料館":
                landmarks = []
            case "記念碑":
                landmarks = [ "新島襄海外渡航の地碑"]
            case "体験・アクティビティー":
                landmarks = []
            case "閉館":
                landmarks = []
            default:
                break
            }
            
        case "Tachimachi_misaki":
            switch genreText {
            case "歴史的建造物（一般入場可能）":
                landmarks = []
            case "歴史的建造物（外観見学のみ）":
                landmarks = []
            case "教会・寺院":
                landmarks = []
            case "資料館":
                landmarks = []
            case "記念碑":
                landmarks = []
            case "体験・アクティビティー":
                landmarks = []
            case "閉館":
                landmarks = []
            default:
                break
            }
        default:
            break
        }
    }
    
    //セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    //セクションタイトルを指定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "函館"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier:"cell")
        
        switch indexPath.section {
        case 0:
            // セルに表示する値を設定する
            cell.textLabel!.text = landmarks[indexPath.row]
             cell.detailTextLabel?.text = ""
            //cell.imageView?.image = UIImage(named: photos[indexPath.row])
            cell.detailTextLabel?.numberOfLines = 0
            
        default:
            break
        }
        
        return cell
    }
    
    //タップされた時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(landmarks[indexPath.row])番目の行が選択されました。")
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        selectText = landmarks[indexPath.row]
        
        
        // 別の画面に遷移
        performSegue(withIdentifier: "toFacilitiesVC", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toFacilitiesVC") {
            let nextVC: FacilitiesViewController = (segue.destination as? FacilitiesViewController)!
            nextVC.landmarkText = selectText
            nextVC.facilitiesText = facilitiesText
            nextVC.areaText = areaText
            //switch文も使用可能
        }
    }
    
}



