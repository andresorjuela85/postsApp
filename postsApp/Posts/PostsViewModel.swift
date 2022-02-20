//
//  PostsViewModel.swift
//  postsApp
//
//  Created by Camilo Orjuela on 19/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation

class PostsViewModel {
    
    var posts: [Post] = []
    var service = PostService()
    var database = PostDatabase()
    var onGetPosts: (()-> Void)?
    var loading: ((Bool) -> Void)?
    
    func getPosts() {
        
        self.loading?(true)
        
        service.getPosts { [weak self] postReceived in
            
            self?.loading?(false)
            
            if let postReceived = postReceived {
                self?.database.savePosts(postReceived)
            }
            
            self?.posts = self?.database.getPosts().sorted(by: { (post1, post2) -> Bool in
                return post1.favorite
            }) ?? []
            self?.onGetPosts?()
        }
    }
    
    func filterPosts(showFavorites: Bool) {
        if showFavorites {
            self.posts = self.database.getPosts().filter({ (post) -> Bool in
                return post.favorite
            })
        } else {
            self.posts = self.database.getPosts().sorted(by: { (post1, post2) -> Bool in
                return post1.favorite
            })
        }
    }
}
