//
//  HomeController.swift
//  ICDDRBTask
//
//  Created by Romana on 27/10/22.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var titleView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.text = "Student List"
        return view
    }()
    
    var searchView: UITextField = {
        let view = UITextField()
        view.placeholder = "Search a Student By Name"
        view.returnKeyType = .next
        view.borderStyle = .roundedRect
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardType = .asciiCapable
        return view
    }()
    
    var addBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Add New", for: .normal)
        view.backgroundColor = hexStringToUIColor(hex: "#FD9726")
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 15)
        view.layer.cornerRadius = 5
        return view
    }()
    
    var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    var studentArray = [StudentModel]()
    var filteredData = [StudentModel]()
    var cellID = "tableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(titleView)
        self.view.addSubview(searchView)
        self.view.addSubview(addBtn)
        self.view.addSubview(tableView)
        
        let constraints = [
            titleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            titleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            addBtn.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 30),
            addBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            addBtn.heightAnchor.constraint(equalToConstant: 30),
            addBtn.widthAnchor.constraint(equalToConstant: 90),
            
            searchView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 30),
            searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: self.addBtn.leadingAnchor, constant: -10),
            searchView.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: self.searchView.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchView.delegate = self
        
        tableView.register(StudentTableViewCell.self, forCellReuseIdentifier: cellID)
        addBtn.addTarget(self, action: #selector(self.addNew), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("home appear")
        studentArray = RealmHandler().getStudentListFromRealm()
        filteredData = studentArray
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! StudentTableViewCell
        cell.name.text = "Name : \(self.filteredData[indexPath.row].stdName)"
        cell.age.text = "Age : \(self.filteredData[indexPath.row].stdAge) Years"
        cell.gender.text = "Sex : \(self.filteredData[indexPath.row].stdGender)"
        cell.date.text = "Date: \(self.filteredData[indexPath.row].stdEntryDate)"
        return cell
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let searchText: String = textField.text!
        if searchText.isEmpty {
            filteredData = studentArray
        } else {
            filteredData =  studentArray.filter { $0.stdName.localizedCaseInsensitiveContains(searchText) }
        }
        
        self.tableView.reloadData()
    }
    
    @objc func addNew(){
        let viewController = AddController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
}
