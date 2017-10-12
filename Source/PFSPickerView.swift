//
//  PFSPickerView.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 11/07/2017.
//
//

import UIKit
import SnapKit

public protocol PFSPickerViewItem {
    var title: String {get set}
}


public class PFSPickerView<T :PFSPickerViewItem>: UIView, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    fileprivate var pickerView = UIPickerView()
    
    fileprivate var toolBar = UIToolbar()
    
    fileprivate var backgroundView = UIView()
    
    var height: Float = 260
    
    var completeHandler: ((_ item: T) -> Void)?
    
    fileprivate var dataSource: [T] = [T]()
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataSource.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = self.dataSource[row].title
        label.textAlignment = .center
        return label
    }
    
    convenience init(height: Float = 260, items: [T]) {
        self.init(frame: .zero)
        self.height = height
        self.dataSource.append(contentsOf: items)
        self.pickerView.selectRow(0, inComponent: 0, animated: true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func showPicker() {
        
        
    }
    
    override public func updateConstraints() {
        
        self.addSubview(backgroundView)
        
        backgroundView.alpha = 0.8
        backgroundView.backgroundColor = UIColor.lightGray
        backgroundView.snp.updateConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        self.addSubview(pickerView)
        
        pickerView.snp.updateConstraints { maker in
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        
        pickerView.backgroundColor = UIColor.white
        
        self.addSubview(toolBar)
        
        toolBar.snp.updateConstraints { maker in
            maker.bottom.equalTo(pickerView.snp.top)
            maker.leading.equalTo(pickerView.snp.leading)
            maker.trailing.equalTo(pickerView.snp.trailing)
        }
        
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        toolBar.addSubview(view)
        
        view.snp.updateConstraints { maker in
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(0.5)
        }
        
        toolBar.isTranslucent = false
        
        let done = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(PFSPickerView.done))
        
        let cancel = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(PFSPickerView.cancel))
        
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([cancel, fixedSpace ,done], animated: false)
        
        
        super.updateConstraints()
    }
    
    @objc func done()  {
        self.removeFromSuperview()
        let index = self.pickerView.selectedRow(inComponent: 0)
        if let completeHandler = self.completeHandler {
            completeHandler(self.dataSource[index])
        }
    }
    
    @objc func cancel()  {
        self.removeFromSuperview()
    }
    
    
    
}

