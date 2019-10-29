//
//  RealmManager.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/29/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

// MARK: Checked and re-use realm manager from other member.
import Foundation
import RealmSwift

final class RealmManager {
    static var shared = RealmManager()
    private let realm: Realm? = {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let url = documentDirectory.appendingPathComponent("Dating.realm")
            return try Realm(fileURL: url)
        } catch {
            return nil
        }
    }()
    
    private init() { }
}

extension RealmManager {
    private func write(_ closesure: () -> Void, completion: ((RealmResult) -> Void)? = nil) {
        realm?.beginWrite()
        closesure()
        do {
            try realm?.commitWrite()
            completion?(.success)
        } catch {
            realm?.cancelWrite()
            completion?(.failure(error))
        }
    }

    func fetchObjects<T: Object>(_ type: T.Type, filter predicate: NSPredicate? = nil) -> Results<T>? {
        guard let predicate = predicate else {
            return realm?.objects(type)
        }
        return realm?.objects(type).filter(predicate)
    }

    func fetchObject<T: Object>(_ type: T.Type, filter predicate: NSPredicate? = nil) -> T? {
        let results = fetchObjects(type, filter: predicate)
        return results?.first
    }

    func add<T: Object>(object: T, completion: ((RealmResult) -> Void)? = nil) {
        write({
            realm?.add(object)
        }, completion: completion)
    }

    func add<T: Object>(objects: [T], completion: ((RealmResult) -> Void)? = nil) {
        write({
            realm?.add(objects)
        }, completion: completion)
    }

    func delete<T: Object>(object: T, completion: ((RealmResult) -> Void)? = nil) {
        write({
            realm?.delete(object)
        }, completion: completion)
    }

    func deleteAll<T: Object>(objects: [T], completion: ((RealmResult) -> Void)? = nil) {
        write({
            realm?.delete(objects)
        }, completion: completion)
    }

    func observe<T: Object>(type: T.Type, completion: @escaping (RealmCollectionChange<Results<T>>) -> Void) -> NotificationToken? {
        let notificationToken = realm?.objects(type).observe({ (change) in
            completion(change)
        })
        return notificationToken
    }
}

extension RealmManager {
    enum RealmResult {
        case success
        case failure(Error)
    }
}
