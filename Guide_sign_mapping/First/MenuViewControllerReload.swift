
import UIKit

class MenuViewControllerReload: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
        cell.textLabel!.text = Facilities[indexPath.row]
        //cell.imageView?.image = UIImage(named: photos[indexPath.row])
        return cell
    }
    
    //タップされた時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // タップされたセルの行番号を出力
        print("\(Facilities[indexPath.row])番目の行が選択されました。")
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        let toFirst = storyboard?.instantiateViewController(withIdentifier: "First") as! ViewController
        
        toFirst.facilitiesText = Facilities[indexPath.row]
        
        toFirst.loadView()
        toFirst.viewDidLoad()
        toFirst.viewDidAppear(true)
        
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

