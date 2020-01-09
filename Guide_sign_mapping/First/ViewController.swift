import UIKit

final class ViewController: UICollectionViewController {
    
    private var cellSize: CGSize {
        let width = collectionView.bounds.width * 0.3
        let height = width
        return CGSize(width: width, height: height)
    }
    
    private var headerSize: CGSize {
        let width = collectionView.bounds.width * 0.3
        return CGSize(width: width, height: 0)
    }
    
    var facilitiesText:String = ""
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //tab
        collectionView.decelerationRate = .fast
        
        let flowLayout = collectionViewLayout as! FlowLayout
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = cellSize
        flowLayout.minimumInteritemSpacing = collectionView.bounds.height
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 500, left: 40, bottom: 0, right: 40)
    }
    
    //tabbar
    //collectionの初期位置
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(item: 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return Facilities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        
        cell.label.text =  "\(Facilities[indexPath.row])"
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: "noimage")
        
        
        
        return cell
    }
    
    // Cell が選択された場合
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        print(Facilities[indexPath.row])
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = .red
        }
        
        //タップしたらセルの移動
        collectionView.scrollToItem(at: IndexPath(item: (indexPath.row), section: 0), at: .centeredHorizontally, animated: true)

        
        for selectFacilities in 0 ..< Facilities.count{
            if(facilitiesText == Facilities[selectFacilities]){
                collectionView.scrollToItem(at: IndexPath(item: selectFacilities, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
        
         print(facilitiesText)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.clear
        }
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind _: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath)
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let collectionView = scrollView as! UICollectionView
        (collectionView.collectionViewLayout as! FlowLayout).prepareForPaging()
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection _: Int) -> CGSize {
        return headerSize
    }
}


