//
//  Users.swift
//  postsApp
//
//  Created by Camilo Orjuela on 20/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation
import RealmSwift

struct UserRemote: Codable {
    
    let id: Int
    let name: String?
    let email: String?
    let phone: String?
    let website: String?
}

class User: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var phone: String?
    @objc dynamic var email: String?
    @objc dynamic var website: String?
}
