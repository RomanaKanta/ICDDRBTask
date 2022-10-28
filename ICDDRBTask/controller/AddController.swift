//
//  AddController.swift
//  ICDDRBTask
//
//  Created by Romana on 27/10/22.
//

import UIKit

class AddController: BaseViewController, UITextFieldDelegate {
    
    var date: UITextField = {
        let view = UITextField()
        view.placeholder = "Entry Date"
        view.borderStyle = .roundedRect
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var time: UITextField = {
        let view = UITextField()
        view.placeholder = "Entry Time"
        view.borderStyle = .roundedRect
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var name: UITextField = {
        let view = UITextField()
        view.placeholder = "Full Name"
        view.returnKeyType = .next
        view.borderStyle = .roundedRect
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardType = .asciiCapable
        return view
    }()
    
    var age: UITextField = {
        let view = UITextField()
        view.placeholder = "Age"
        view.borderStyle = .roundedRect
        view.backgroundColor = .white
        view.returnKeyType = .done
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardType = .numberPad
        return view
    }()
    
    var addBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Add", for: .normal)
        view.backgroundColor = hexStringToUIColor(hex: "#FD9726")
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 18)
        view.layer.cornerRadius = 10
        return view
    }()
    
    var backBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Cancel", for: .normal)
        view.backgroundColor = .white
        view.setTitleColor(hexStringToUIColor(hex: "#FD9726"), for: .normal)
        view.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 18)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = hexStringToUIColor(hex: "#FD9726").cgColor
        return view
    }()
    
    var datePicker : UIDatePicker!
    var isDate: Bool = true
    
    var segmentControl: UISegmentedControl!
    var selectedGender: String = "Male"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollView()
        setView()
    }
    
    func setView(){
        
        setSegmentControl()
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        
        stackView.addArrangedSubview(getInputFieldView(label: "Entry Date", field: date))
        stackView.addArrangedSubview(getInputFieldView(label: "Entry Time", field: time))
        stackView.addArrangedSubview(getInputFieldView(label: "Full Name", field: name))
        stackView.addArrangedSubview(getInputFieldView(label: "Age", field: age))
        stackView.addArrangedSubview(getInputFieldView(label: "Gender", field: segmentControl, axis: .horizontal))
        stackView.addArrangedSubview(addBtn)
        stackView.addArrangedSubview(backBtn)
        
        date.delegate = self
        time.delegate = self
        name.delegate = self
        age.delegate = self
        
        scrollContentView.addSubview(stackView)
        
        let constraints = [
            addBtn.heightAnchor.constraint(equalToConstant: 40),
            
            backBtn.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo: self.scrollContentView.topAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: self.scrollContentView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.scrollContentView.trailingAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(constraints)
        
        addBtn.addTarget(self, action: #selector(self.submit), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        
    }
    
    func setSegmentControl(){
        let segmentItems = ["Male", "Female"]
        segmentControl = UISegmentedControl(items: segmentItems)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.backgroundColor = .white
        segmentControl.addTarget(self, action: #selector(selectionChange(_:)), for: .valueChanged)
        if #available(iOS 13.0, *) {
            segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            segmentControl.setTitleTextAttributes([.foregroundColor: hexStringToUIColor(hex: "#FD9726")],
                                                  for: .normal)
            segmentControl.selectedSegmentTintColor = hexStringToUIColor(hex: "#FD9726")
        }else{
            segmentControl.tintColor = hexStringToUIColor(hex: "#FD9726")
        }
        segmentControl.selectedSegmentIndex = 0
        selectionChange(segmentControl!)
        self.view.addSubview(segmentControl)
    }

    
    func getInputFieldView(label: String, field: UIView, axis: NSLayoutConstraint.Axis = .vertical) -> UIStackView{
        let view = UIStackView()
        view.axis = axis
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.text = label
        
        view.addArrangedSubview(title)
        view.addArrangedSubview(field)
        return view
    }
    
    @objc func selectionChange(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            selectedGender = "Male"
            break
            
        case 1:
            selectedGender = "Female"
            break
            
        default:
            break
        }
    }
    
    @objc func submit(){
        hideKeyboard()
        let student = StudentModel()
        student.id = student.IncrementaID()
        student.stdName = name.text!
        student.stdAge = age.text!
        student.stdGender = selectedGender
        student.stdEntryDate = date.text!
        student.stdEntryTime = time.text!
        
        let realm = RealmHandler()
        realm.writeStudentDataInRealm(object: student)
        
        let alert = UIAlertController(title: "", message: "Inforamtion stored in Database successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive) { (alert: UIAlertAction!) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true, completion:nil)
        
    }
    
    @objc func back(){
        hideKeyboard()
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case name:
            return !age.becomeFirstResponder()
        default:
            return age.resignFirstResponder()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setActiveField(field: textField)
        if (textField == date){
            forDate()
        }else if (textField == time){
            forTime()
        }else{}
    }
    
    func forDate(){
        isDate = true
        self.pickUpDate(self.date)
    }
    
    func forTime(){
        isDate = false
        self.pickUpDate(self.time)
    }
    
    
}

extension AddController{
    
    func pickUpDate(_ textField : UITextField){
        
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        
        if(isDate){
            self.datePicker.datePickerMode = UIDatePicker.Mode.date
        }else{
            self.datePicker.datePickerMode = UIDatePicker.Mode.time
        }
        
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneClick() {
        if(isDate){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy";
            date.text = dateFormatter.string(from: datePicker.date)
            date.resignFirstResponder()
        }else{
            let formatter = DateFormatter()
            formatter.locale = .init(identifier: "em_US_POSIX")
            formatter.dateFormat = "HH:mm"
            time.text = formatter.string(from: datePicker.date)
            time.resignFirstResponder()
        }
        
    }
    
    @objc func cancelClick() {
        if(isDate){
            date.resignFirstResponder()
        }else{
            time.resignFirstResponder()
        }
        
    }
    
    
}
