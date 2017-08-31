//
//  PFSTableViewController.swift
//  IBLNetAssistant
//
//  Created by 李智慧 on 02/07/2017.
//  Copyright © 2017 李智慧. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh

protocol RMTableViewRefresh: class {
    func headerRefreshingFor(tableView: UITableView)
    
    func footerRefreshingFor(tableView: UITableView)
}

extension UITableView {
    func headerRefresh(enable: Bool, target: RMTableViewRefresh)  {
        if enable {
            weak var x = target
            self.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
                if let strongSelf = self, let strongTarget = x {
                    strongTarget.headerRefreshingFor(tableView: strongSelf)
                }
            })
        }else{
            self.mj_header = nil
        }
    }
    
    func footerRefresh(enable: Bool, target: RMTableViewRefresh) {
        if enable {
            weak var x = target
            
            self.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {[weak self] in
                if let strongSelf = self, let strongTarget = x {
                    strongTarget.footerRefreshingFor(tableView: strongSelf)
                }
            })
        }else{
            self.mj_footer = nil
        }
    }
}

class PFSTableViewCell: UITableViewCell {
    
    private(set) var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        self.layoutMargins = UIEdgeInsetsZero //or UIEdgeInsetsMake(top, left, bottom, right)
        self.separatorInset = UIEdgeInsetsZero //if you also want to adjust separatorInset
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag() // because life cicle of every cell ends on prepare for reuse
    }
    
}

extension PFSTableviewController: RMTableViewRefresh{
    
    func footerRefreshingFor(tableView: UITableView) {}
    
    func headerRefreshingFor(tableView: UITableView) {}
}

open class PFSTableViewController: PFSViewController {
    
    @IBOutlet var tableViews: [UITableView]!
    
    var tableView: UITableView {
        return tableViews[0]
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.emptyFooterView()

    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func emptyFooterView()  {
        for tableView in self.tableViews {
            tableView.tableFooterView = UIView()
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 40
        }
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
