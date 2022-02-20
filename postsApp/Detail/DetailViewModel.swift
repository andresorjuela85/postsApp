//
//  DetailViewModel.swift
//  postsApp
//
//  Created by Camilo Orjuela on 19/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation
import Alamofire

class DetailViewModel {
    
    var userPost: User?
    var post: Post
    var comments: [Comment] = []
    var service = PostService()
    var onGetPost: (() -> Void)?
    var loading: ((Bool) -> Void)?
    var database = PostDatabase()
    
    init(post: Post) {
        self.post = post
    }
    
    func getDetailPost() {
        
        self.loading?(true)
        
        service.getUser(userId: post.userId) { [weak self] user in
            
            self?.loading?(false)
            
            if let user = user {
                self?.database.saveUser(user)
            }
            
            self?.userPost = self?.database.getUser(id: self?.post.userId ?? 0)
            self?.onGetPost?()
        }
        
        service.getComments { [weak self] comments in
            
            if let comments = comments {
                self?.database.saveComment(comments)
            }
            
            self?.comments = self?.database.getComments(postId: self?.post.id ?? 0) ?? []
            self?.onGetPost?()
        }
    }
    
    func updateFavorite() {
        self.database.updateFavorite(post: post)
    }
    
    func deletePost() {
        self.database.deletePost(post: post)
    }
}

