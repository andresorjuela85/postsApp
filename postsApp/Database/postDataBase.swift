//
//  postDataBase.swift
//  postsApp
//
//  Created by Camilo Orjuela on 19/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation
import RealmSwift

class PostDatabase {
    
    func savePosts(_ posts: [PostRemote]) {
        
        do {
            let realm = try Realm()
            let allObjects = realm.objects(Post.self)
            
            try realm.write {
                realm.delete(allObjects)
            }
            
            for post in posts {
            
                let postsRealm = Post()
                postsRealm.id = post.id
                postsRealm.userId = post.userId ?? 0
                postsRealm.title = post.title
                postsRealm.body = post.body
                try realm.write {
                    realm.add(postsRealm)
                }
            }
            
        } catch {
            print("Database error")
        }
    }
    
    func getPosts() -> [Post] {
        
        do {
            let realm = try Realm()
            return Array(realm.objects(Post.self))
        } catch {
            print("Database error")
            return []
        }
    }
    
    func saveUser(_ user: UserRemote) {
        
        do {
            let realm = try Realm()
            let object = realm.objects(User.self).filter("id = \(user.id)")
            
            try realm.write {
                realm.delete(object)
            }
            
            let usersRealm = User()
            usersRealm.id = user.id
            usersRealm.name = user.name
            usersRealm.email = user.email
            usersRealm.phone = user.phone
            usersRealm.website = user.website
            try realm.write {
                realm.add(usersRealm)
            }
            
        } catch {
            print("Database error")
        }
    }
    
    func getUser(id: Int) -> User? {
        
        do {
            let realm = try Realm()
            return realm.objects(User.self).filter("id = \(id)").first
        } catch {
            print("Database error")
            return nil
        }
    }
    
    func saveComment(_ comments: [CommentRemote]) {
        
        do {
            let realm = try Realm()
            let allObjects = realm.objects(Comment.self)
            
            try realm.write {
                realm.delete(allObjects)
            }
            
            for comment in comments {
            
                let commentsRealm = Comment()
                commentsRealm.id = comment.id
                commentsRealm.postId = comment.postId ?? 0
                commentsRealm.name = comment.name
                commentsRealm.email = comment.email
                commentsRealm.body = comment.body
                
                try realm.write {
                    realm.add(commentsRealm)
                }
            }
        } catch {
            print("Database error")
        }
    }
    
    func getComments(postId: Int) -> [Comment] {
        
        do {
            let realm = try Realm()
            return Array(realm.objects(Comment.self).filter("postId = \(postId)"))
        } catch {
            print("Database error")
            return []
        }
    }
    
    func updateFavorite(post: Post) {
        
        do {
            let realm = try Realm()
            try realm.write {
                post.favorite = !post.favorite
            }
            
        } catch {
            print("Database error")
        }
    }
    
    func deletePost (post: Post) {
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(post)
            }
            
        } catch {
            print("Database error")
        }
    }
}

