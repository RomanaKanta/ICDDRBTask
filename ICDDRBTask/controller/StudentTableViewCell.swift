//
//  tableViewCell.swift
//  ICDDRBTask
//
//  Created by Romana on 27/10/22.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
    lazy var name = getLabelView()
    lazy var age = getLabelView()
    lazy var gender = getLabelView()
    lazy var date = getLabelView()
    let bgView = CardView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = getVStackView()
        
        stackView.addArrangedSubview(getHStackView(view1: name, view2: age))
        stackView.addArrangedSubview(getHStackView(view1: date, view2: gender))
        
        addSubview(stackView)
        
        let constraints = [
            bgView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            stackView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -15),
            stackView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -15),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func getVStackView() -> UIStackView{
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func getHStackView(view1: UIView, view2: UIView) -> UIStackView{
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(view1)
        view.addArrangedSubview(view2)
        return view
    }
    
    func getLabelView() -> UILabel{
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 15)
        view.numberOfLines = 0
        return view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
