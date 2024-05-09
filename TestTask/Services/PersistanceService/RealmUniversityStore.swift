//
//  RealmUniversityStore.swift
//  TestTask
//
//  Created by Rajat Pagare on 09/05/24.
//

import Foundation
import RealmSwift

class RealmUniversityStore {
	var realm: Realm = try! Realm()

	func saveUniversity(_ university: RealmUniversity) {
		try! realm.write {
			realm.add(university)
		}
	}

	func deleteAllObjects() {
		try! realm.write {
			realm.deleteAll()
		}
	}

	func getAllUniversities() -> [RealmUniversity] {
		let realmResults = realm.objects(RealmUniversity.self)
		return Array(realmResults)
	}
}
