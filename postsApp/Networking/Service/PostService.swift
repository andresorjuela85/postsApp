//
//  PostService.swift
//  postsApp
//
//  Created by Camilo Orjuela on 19/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation
import Alamofire

class PostService {
    
    func getPosts(completion: @escaping ([PostRemote]?) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/posts").responseDecodable(of: [PostRemote].self) {
            
            response in
            
            guard let postReceived = response.value else {
                completion(nil)
                return
            }
            
            completion(postReceived)
        }
    }
    
    func getUser(userId: Int, completion: @escaping (UserRemote?) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/users/\(userId)").responseDecodable(of: UserRemote.self) {
            
            response in
            
            guard let userReceived = response.value else {
                completion(nil)
                return
            }
            
            completion(userReceived)
        }
    }
    
    func getComments(completion: @escaping ([CommentRemote]?) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/comments").responseDecodable(of: [CommentRemote].self) {
            
            response in
            
            guard let commentReceived = response.value else {
                completion(nil)
                return
            }
            
            completion(commentReceived)
        }
    }
    
}
