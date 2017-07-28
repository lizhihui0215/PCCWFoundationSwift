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
import Result
import Moya
import Toaster



extension UIViewController: PFSViewAction {
    public func alert(message: String, success: Bool = true) -> Driver<Bool> {
        return Observable.create({ element -> Disposable in
            let  alertView = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "确定", style: .default, handler: { action in
                if success {
                    element.onNext(true)
                    element.onCompleted()
                }else {
                    element.onError(error(message: message))
                }
            })
            
            alertView.addAction(action)
            self.present(alertView, animated: true)
            return Disposables.create{
                alertView.dismiss(animated: true, completion: nil)
            }
        }).asDriver(onErrorJustReturn: false)
    }
    
    public func confirm<T>(message: String, content: T? = nil) -> Driver<T?> {
        return Observable.create({ element -> Disposable in
            let  alertView = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "确定", style: .default, handler: { action in
                element.onNext(content)
                element.onCompleted()
            })
            
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: { action in
                element.onError(error(message: "cancel"))
                element.onCompleted()
            })
            
            alertView.addAction(action)
            alertView.addAction(cancel)
            self.present(alertView, animated: true)
            return Disposables.create{
                alertView.dismiss(animated: true, completion: nil)
            }
        }).asDriver(onErrorJustReturn: content)
    }

    public func alert<T>(result: Result<T, MoyaError>) -> Driver<Result<T, MoyaError>>{
        return Observable.create({ element -> Disposable in
            let  alertView = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "确定", style: .cancel, handler: { _ in
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.addAction(cancel)
            switch result {
            case .failure(let error):
                alertView.message = error.errorDescription
                self.present(alertView, animated: true, completion: nil)
                element.onCompleted()
            case.success:
                element.onNext(result)
                element.onCompleted()
            }
           return Disposables.create{
//                alertView.dismiss(animated: true, completion: nil)
            }
        }).asDriver(onErrorJustReturn: result)
    }
    
    
    public func toast(message: String) -> Driver<Bool> {
        return Observable.create{ observer in
            let toast = Toast(text: message, duration: 0.5)
            toast.show()
            return Disposables.create{
                toast.cancel()
            }
            }.asDriver(onErrorJustReturn: false)
    }

    
}

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
    
    public func presentPicker<T: PFSPickerViewItem>(items: [T],  completeHandler: @escaping ((_ item: T) -> Void))  {
        let picker = PFSPickerView<T>(items: items)
        picker.completeHandler = completeHandler
        
        self.view.addSubview(picker)
        picker.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
    }
}

open class PFSViewController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PFSViewController.backgroundTapped))
        self.view.addGestureRecognizer(tap)
        
        tap.cancelsTouchesInView = false


    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func backgroundTapped()  {
        self.view.endEditing(true)
    }

    
    #if DEBUG

    deinit {
        debug("DEBUG", model: type(of: self), content: "deinit")
    }
    
    #endif
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
