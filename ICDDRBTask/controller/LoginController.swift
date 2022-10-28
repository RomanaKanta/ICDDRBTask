//
//  LoginController.swift
//  Recognizer
//
//  Created by Romana on 26/10/22.
//

import UIKit

class LoginController: BaseViewController, UITextFieldDelegate {
  
    var logo: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "logo")
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var username: UITextField = {
        let view = UITextField()
        view.placeholder = "Username"
        view.returnKeyType = .next
        view.borderStyle = .roundedRect
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardType = .asciiCapable
        view.text = "user"
        return view
    }()
    
    var password: UITextField = {
        let view = UITextField()
        view.placeholder = "Password"
        view.borderStyle = .roundedRect
        view.backgroundColor = .white
        view.returnKeyType = .done
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardType = .asciiCapable
        view.isSecureTextEntry = true
        view.text = "user123"
        return view
    }()
    
    var loginBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Login", for: .normal)
        view.backgroundColor = hexStringToUIColor(hex: "#FD9726")
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 18)
        view.layer.cornerRadius = 10
        return view
    }()
    
    var errorText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .red
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 16)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollView()
        setView()
    }
    
    func setView(){
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 50
        
        stackView.addArrangedSubview(logo)
        stackView.addArrangedSubview(username)
        stackView.addArrangedSubview(password)
        stackView.addArrangedSubview(loginBtn)
        stackView.addArrangedSubview(errorText)
        
        username.delegate = self
        password.delegate = self
        
        scrollContentView.addSubview(stackView)
        
        let constraints = [
            loginBtn.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo: self.scrollContentView.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: self.scrollContentView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.scrollContentView.trailingAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(constraints)
        
        loginBtn.addTarget(self, action: #selector(self.login), for: .touchUpInside)
    }
    
    @objc func login(){
        hideKeyboard()
        if validationCheck(){
            let viewController = HomeController()
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }else{
            self.errorText.text = "Invalid User Credential"
        }
    }
    
    func validationCheck()-> Bool{
        if (self.username.text! != "user"){
            return false
        }
        if (self.password.text! != "user123"){
            return false
        }
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.errorText.text = ""
        setActiveField(field: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case username:
            return !password.becomeFirstResponder()
        default:
            return password.resignFirstResponder()
        }
    }
    
   
}
