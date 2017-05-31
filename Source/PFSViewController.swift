//
//  RMViewController.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 19/04/2017.
//
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    private struct AssociatedKeys {
        static var disposeBagKey = "com.pccw.foundation.viewcontroller.disposebagkey"
    }
    
    public var disposeBag: DisposeBag {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.disposeBagKey) as! DisposeBag
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.disposeBagKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open func pfs_viewDidLoad()  {
        self.pfs_viewDidLoad()
        disposeBag = DisposeBag()
    }
    
}

open class PFSViewController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
