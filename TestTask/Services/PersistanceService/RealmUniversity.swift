//
//  RealmUniversity.swift
//  TestTask
//
//  Created by Rajat Pagare on 09/05/24.
//

import RealmSwift

class RealmUniversity: Object {
	@objc dynamic var stateProvince = ""
	var domains = List<String>()
	var webPages = List<String>()
	@objc dynamic var name = ""
	@objc dynamic var code = ""
	@objc dynamic var country = ""
	@objc dynamic var identifier = ""
}
