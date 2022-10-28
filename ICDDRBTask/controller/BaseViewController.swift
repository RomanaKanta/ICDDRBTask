//
//  BaseViewController.swift
//  ICDDRBTask
//
//  Created by Romana on 27/10/22.
//

import UIKit

class BaseViewController: UIViewController {
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + self.scrollBottomInset)
    
    lazy var scrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame.size = contentViewSize
        return view
    }()
    
    var parentView: UIScrollView!
    var scrollBottomInset: CGFloat = 200
    let keyboardBottomInset: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    func setScrollView(view: UIScrollView! = nil) {
            parentView = UIScrollView(frame: self.view.bounds)
            parentView.backgroundColor = .clear
            parentView.contentSize = contentViewSize
            parentView.addSubview(scrollContentView)
            parentView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: scrollBottomInset, right: 0)
            self.view.addSubview(parentView)
    }

    ///////   keyboard  /////////
    var activeTextField: UITextField! = nil
    let keyboardDoneButtonView = UIToolbar()
    
    override func viewWillAppear(_ animated: Bool) {
        addDoneButtonOnKeyboard()
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func addDoneButtonOnKeyboard(){
        // keyboard ToolBar
        keyboardDoneButtonView.barStyle = .default
        keyboardDoneButtonView.isTranslucent = true
        keyboardDoneButtonView.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        keyboardDoneButtonView.sizeToFit()
        
        // Adding Button in keyboard ToolBar
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.hideKeyboard))
        
        keyboardDoneButtonView.setItems([flexSpace, doneButton], animated: false)
        keyboardDoneButtonView.isUserInteractionEnabled = true
    }
    
    @objc func keyboardDidShow(notification: Notification){
        if parentView != nil{
            guard let userinfo = notification.userInfo,
                  let frame = (userinfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
            }
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (frame.height + keyboardBottomInset), right: 0)
            parentView.contentInset = contentInset
        }
    }
    
    @objc func keyboardWillHide(notification: Notification){
        if parentView != nil {
            parentView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: scrollBottomInset, right: 0)
        }
    }
    
    func setActiveField(field: UITextField!){
        self.activeTextField = field
        if (activeTextField != nil) {
            if ((self.activeTextField.keyboardType == UIKeyboardType.decimalPad) ||
                (self.activeTextField.keyboardType == UIKeyboardType.numberPad) ||
                (self.activeTextField.keyboardType == UIKeyboardType.asciiCapableNumberPad)) {
                self.activeTextField.inputAccessoryView = self.keyboardDoneButtonView
            }else{
                self.activeTextField.inputAccessoryView = nil
            }
        }
    }
    
    @objc func hideKeyboard(){
        if(activeTextField != nil){
            activeTextField.resignFirstResponder()
        }
    }
    

}
