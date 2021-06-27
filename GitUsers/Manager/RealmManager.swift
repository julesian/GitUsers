//
//  RealmManager.swift
//  GitUsers
//
//  Created by Jules Gilos on 6/27/21.
//

import RealmSwift

struct RealmManager {
    static let shared = RealmManager()
    let realm: Realm!
    
    init() {
        do {
            realm = try Realm()
        } catch {
            Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
            realm = try? Realm()
        }
    }
    
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            // Error
        }
    }

    func create<T: Object>(_ objects: [T]) {
        do {
            try realm.write {
                realm.add(objects, update: .all)
            }
        } catch {
            // Error
        }
    }

    func createOrUpdate<T: Object>(_ object: T) {
        do {
            try realm.write {
                let policy: Realm.UpdatePolicy = object.realm == nil ? .all : .modified
                realm.add(object, update: policy)
            }
        } catch {
            // Error
        }
    }

    func createOrUpdate<T: Object>(_ objects: [T]) {
        do {
            try realm.write {
                for object in objects {
                    let policy: Realm.UpdatePolicy = object.realm == nil ? .all : .modified
                    realm.add(object, update: policy)
                }
            }
        } catch {
            // Error
        }
    }

    func read<T: Object>(_ object: T.Type) -> Results<T> {
        return realm.objects(object.self)
    }

    func read<T: Object>(_ object: T.Type, id: String) -> T? {
        return realm.object(ofType: object, forPrimaryKey: id)
    }
}

extension Object {
    typealias BasicCallback = (() -> Void)
    func createOrUpdate(_ updates: BasicCallback? = nil) {
        let realm = RealmManager.shared.realm
        do {
            try realm?.write {
                let policy: Realm.UpdatePolicy = self.realm == nil ? .all : .modified
                updates?()
                realm?.add(self, update: policy)
            }
        } catch {
            // Error
        }
    }
}
