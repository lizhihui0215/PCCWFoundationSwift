//
//  RMViewController.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 19/04/2017.
//
//

import UIKit

private var viewModelKey: Void?


public protocol PFSViewControllerProtocol {
    associatedtype T: PFSViewModel

    var viewModel: T {get set}
}

extension UIViewController: PFSViewControllerProtocol {
    public var viewModel: PFSViewModel {
        get {
            return objc_getAssociatedObject(self, &viewModelKey) as! T
        }
        set {
            objc_setAssociatedObject(self, &viewModelKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
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
