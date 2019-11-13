//
//  FirstViewController.swift
//  Guide_sign_mapping
//
//  Created by yuya on 2019/11/12.
//  Copyright © 2019 yuya. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    override func viewDidLoad() {
           super.viewDidLoad()
       }
    
    // ①セグエ実行前処理
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          // ②遷移先ViewCntrollerの取得
          let nextView = segue.destination as! ReceiveViewController
          // ③Segueの識別子確認
          switch segue.identifier {
              case "toReceive" :
                  //④値の設定
                  nextView.number = 5
              default:
                  break
          }
      }
    }
      
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

