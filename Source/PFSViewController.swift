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
import NVActivityIndicatorView


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
                    element.onCompleted()
                }
            })
            self.stopAnimating()
            alertView.addAction(action)
            self.present(alertView, animated: true)
            return Disposables.create{
                alertView.dismiss(animated: true, completion: nil)
            }
        }).asDriver(onErrorJustReturn: false)
    }
    
    public func confirm<T>(content: (String, T?)) -> Driver<(String, Bool, T?)> {
        return Observable.create({ element -> Disposable in
            let  alertView = UIAlertController(title: "", message: content.0, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "确定", style: .default, handler: { action in
                element.onNext((content.0, true, content.1))
                element.onCompleted()
            })
            
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: { action in
                element.onError(error(message: "cancel"))
                element.onCompleted()
            })
            self.stopAnimating()
            alertView.addAction(action)
            alertView.addAction(cancel)
            self.present(alertView, animated: true)
            return Disposables.create{
                alertView.dismiss(animated: true, completion: nil)
            }
        }).asDriver(onErrorJustReturn: (content.0, false, content.1))
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
                self.stopAnimating()
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
    
    public func toast<T>(result: Result<T, MoyaError>) -> Driver<Result<T, MoyaError>>{
        return Observable.create({ element -> Disposable in
            
            switch result {
            case .failure(let error):
                self.stopAnimating()
                let toast = Toast(text: error.errorDescription, duration: 0.5)
                toast.show()
                element.onCompleted()
            case.success:
                element.onNext(result)
                element.onCompleted()
            }
            return Disposables.create{
            }
        }).asDriver(onErrorJustReturn: result)
    }
    
    
}

extension UIViewController: NVActivityIndicatorViewable {
    private struct AssociatedKeys {
        static var disposeBagKey = "com.pccw.foundation.viewcontroller.disposebagkey"
        static var animationContextKey = "com.pccw.foundation.viewcontroller.animationContextKey"
    }
    
    public var animation: Variable<Bool> {
        if let animation = objc_getAssociatedObject(self, &AssociatedKeys.animationContextKey) as? Variable<Bool> {
            return animation
        }
        
        let animation = Variable(false)
        
        objc_setAssociatedObject(self, &AssociatedKeys.animationContextKey, animation, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return animation
    }
    
    public var disposeBag: DisposeBag {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.disposeBagKey) as! DisposeBag
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.disposeBagKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc open func pfs_viewDidLoad()  {
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
        
        self.animation.asObservable().subscribe(onNext: {[weak self] flag in
            if let strongSelf = self ,flag {
                strongSelf.startAnimating()
            }else if let strongSelf = self{
                strongSelf.stopAnimating()
            }
            },onDisposed: {[weak self] in
                if let strongSelf = self {
                    strongSelf.stopAnimating()
                }
        }).disposed(by: disposeBag)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func backgroundTapped()  {
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
