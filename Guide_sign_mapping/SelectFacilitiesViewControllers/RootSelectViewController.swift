import UIKit

class RootSelectViewController: UIViewController {

    @IBOutlet weak var SegmentButton: UISegmentedControl!
    
    private lazy var selectLandmarkViewController: SelectLandmarkViewController = {
        let storyborad = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyborad.instantiateViewController(withIdentifier: "SelectLandmarkVC") as! SelectLandmarkViewController
        add(asChildViewController: viewController)
        return viewController
    }()

    private lazy var selectPictgramViewController: SelectPictgramViewController = {
        let storyborad = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyborad.instantiateViewController(withIdentifier: "SelectPictgramVC") as! SelectPictgramViewController
        add(asChildViewController: viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
           super.viewDidLoad()
           setupView()
       }

       private func setupView() {
           updateView()
       }
    

    
    private func updateView() {
        if SegmentButton.selectedSegmentIndex == 0 {
            remove(asChildViewController: selectPictgramViewController)
            add(asChildViewController: selectLandmarkViewController)
        } else {
            remove(asChildViewController: selectLandmarkViewController)
            add(asChildViewController: selectPictgramViewController)
        }
    }
    
    
    @IBAction func tapSegmentButton(_ sender: UISegmentedControl) {
       updateView()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // 子ViewControllerを追加
        addChild(viewController)
        // Subviewとして子ViewControllerのViewを追加
        view.addSubview(viewController.view)
        // 子Viewの設定
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // 子View Controllerへの通知
        viewController.didMove(toParent: self)
    }

    private func remove(asChildViewController viewController: UIViewController) {
        // 子View Controllerへの通知
        viewController.willMove(toParent: nil)
        // 子ViewをSuperviewから削除
        viewController.view.removeFromSuperview()
        // 子View Controllerへの通知
        viewController.removeFromParent()
    }
    
    

 

}
/*
import UIKit

class RootSelectViewController: UIViewController {
    
    var SelectLandmarkVC:SelectLandmarkViewController = SelectLandmarkViewController()
    var SelectPictgramVC:SelectPictgramViewController = SelectPictgramViewController()
    
    @IBOutlet weak var SegmentButton: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        SegmentButton.setTitle("Landmark", forSegmentAt: 0)
        SegmentButton.setTitle("Pictgram", forSegmentAt: 1)

        self.view.addSubview(SelectPictgramVC.view)
        self.view.addSubview(SelectLandmarkVC.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SegmentButton(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(SelectLandmarkVC.view)
        case 1:
            self.view.bringSubviewToFront(SelectPictgramVC.view)
        default:
            print("")
        }
    }
}
 */
