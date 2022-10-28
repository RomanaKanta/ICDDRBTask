//
//  RealmHandler.swift
//  ICDDRBTask
//
//  Created by Romana on 28/10/22.
//

import Foundation
import RealmSwift

class RealmHandler {
    var realm: Realm?
    
    init() {
        do{
            realm = try Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }catch{
            print("fail to create realm DB")
        }
    }
    
    func writeStudentDataInRealm(object: StudentModel){
        if (realm != nil){
            try! realm!.write {
                realm!.add(object)
            }
        }else{
            print("reaml is nil")
        }
        
    }
    
    func getStudentListFromRealm() -> [StudentModel]{
        if (realm != nil){
            let results = realm!.objects(StudentModel.self)
            print("Count \(results.count)")
            return results.toArray(ofType: StudentModel.self)
        }else{
            print("reaml is nil")
            return []
        }
    }
    
    func deleteAll(){
        if (realm != nil){
            try! realm!.write {
                realm!.deleteAll()
            }
        }else{
            print("reaml is nil")
        }
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
