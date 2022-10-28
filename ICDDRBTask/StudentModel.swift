//
//  StudentModel.swift
//  ICDDRBTask
//
//  Created by Romana on 27/10/22.
//

import Foundation
import RealmSwift

class StudentModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var stdEntryDate: String = ""
    @objc dynamic var stdEntryTime: String = ""
    @objc dynamic var stdName: String = ""
    @objc dynamic var stdAge: String = ""
    @objc dynamic var stdGender: String = ""
    
    override class func primaryKey() -> String? {
           return "id"
       }
    
    func IncrementaID() -> Int{
        let realm = try! Realm()
        if let retNext = realm.objects(StudentModel.self).sorted(byKeyPath: "id").first?.id {
            return retNext + 1
        }else{
            return 1
        }
    }
}
