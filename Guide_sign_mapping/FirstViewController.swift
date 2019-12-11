import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // collection viewのoutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    let photos = ["favorite", "near", "history"]
    let photosName = ["お気に入り", "周辺施設", "履歴"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // レイアウトを調整
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count // 表示するセルの数
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // "Cell" はストーリーボードで設定したセルのID
        let Cell:UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                               for: indexPath)
        
        // Tag番号を使ってImageViewのインスタンス生成
        let imageView = Cell.contentView.viewWithTag(1) as! UIImageView
        // UIImageをUIImageViewのimageとして設定
        let cellImage = UIImage(named: photos[indexPath.row])
        imageView.image = cellImage
        // Tag番号を使ってLabelのインスタンス生成
        let label = Cell.contentView.viewWithTag(2) as! UILabel
        label.text = photosName[indexPath.row]

        return Cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 5
        let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize + 30)
    }
    
    //タップされた時
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("選択されました。")
        
        switch indexPath.row{
            case 0:
            performSegue(withIdentifier: "toFavoriteViewController", sender: nil)
            case 1:
            performSegue(withIdentifier: "toNearViewController", sender: nil)
            case 2:
            performSegue(withIdentifier: "toHistoryViewController", sender: nil)
            default:
            break
        }
        
        

    }
    

}




