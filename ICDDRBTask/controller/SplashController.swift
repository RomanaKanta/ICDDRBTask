//
//  SplashController.swift
//  Recognizer
//
//  Created by Romana on 26/10/22.
//

import UIKit

class SplashController: UIViewController {

    var logo: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "logo")
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(logo)
        
        let constraints = [
            logo.widthAnchor.constraint(equalToConstant: 220),
            logo.heightAnchor.constraint(equalToConstant: 125),
            logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            logo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.logo.transform = .identity
        UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveLinear, animations: { () -> Void in
            self.logo.transform = CGAffineTransform(scaleX: 5.0, y: 5.0)
            self.logo.alpha = 0
        }) { (animationCompleted: Bool) -> Void in
            let viewController = LoginController()
            viewController.modalPresentationStyle = .fullScreen
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.window?.rootViewController = viewController
            self.dismiss(animated: false, completion: nil)
        }
    }
        
}

