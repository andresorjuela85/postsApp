//
//  Comment.swift
//  postsApp
//
//  Created by Camilo Orjuela on 20/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation
import RealmSwift

struct CommentRemote: Codable {
    
    let postId: Int?
    let id: Int
    let name: String?
    let email: String?
    let body: String?
}

class Comment: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var postId: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var body: String?
    @objc dynamic var email: String?
}
