//
//  Post.swift
//  postsApp
//
//  Created by Camilo Orjuela on 19/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation
import RealmSwift

struct PostRemote: Codable {
    
    let id: Int
    let userId: Int?
    let title: String?
    let body: String?
    var favorite: Bool?
}

class Post: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var body: String?
    @objc dynamic var favorite: Bool = false
}
