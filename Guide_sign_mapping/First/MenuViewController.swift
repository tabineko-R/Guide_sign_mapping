
import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet var TableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // メニューの位置を取得する
        let menuPos = self.menuView.layer.position
        // 初期位置を画面の外側にするため、メニューの幅の分だけマイナスする
        self.menuView.layer.position.x = -self.menuView.frame.width
        // 表示時のアニメーションを作成する
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.menuView.layer.position.x = menuPos.x
        },
            completion: { bool in
        })
        
    }
    
    // メニューエリア以外タップ時の処理
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.menuView.layer.position.x = -self.menuView.frame.width
                },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                }
                )
            }
        }
    }
    
     var selectText:String = ""
    
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
    
    //table
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView = UITableView(frame: self.view.frame, style: UITableView.Style.grouped)
        TableView.delegate = self
        TableView.dataSource = self
        TableView.estimatedRowHeight = 100
        TableView.rowHeight = UITableView.automaticDimension
    }
    
    //セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Facilities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier:"cell")
        // セルに表示する値を設定する
        cell.textLabel!.text = Facilities[indexPath.row][0]
        cell.imageView?.image = UIImage(named: Facilities[indexPath.row][2])
        return cell
    }
    
    //タップされた時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        //storyboardでの値の受けわたしｓだとできなかった
        selectText = Facilities[indexPath.row][2]
        
        if(Facilities[indexPath.row][2] == Facilities[0][2]){
            let storyboard: UIStoryboard = self.storyboard!
            let toSelectArea = storyboard.instantiateViewController(withIdentifier: "selectArea") as! FirstScreenViewController
            self.navigationController?.pushViewController(toSelectArea, animated: true)
        }else if(Facilities[indexPath.row][2] == Facilities[1][2]){
            let storyboard: UIStoryboard = self.storyboard!
            let toLandmarks = storyboard.instantiateViewController(withIdentifier: "selectGenre") as! SelectGenreViewController
            self.navigationController?.pushViewController(toLandmarks, animated: true)
        }else{
            performSegue(withIdentifier: "toViewControllerReloadFromMenu", sender: nil)
            
        }

        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.menuView.layer.position.x = -self.menuView.frame.width
        },
            completion: { bool in
                self.dismiss(animated: true, completion: nil)
        }
        )
        
    }
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let VCR: ViewControllerReload = (segue.destination as? ViewControllerReload)!
         VCR.facilitiesText = selectText
     }
 
    
    
}
