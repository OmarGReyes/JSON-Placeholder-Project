//
//  PostListLocalDataManager.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 17/03/22.
//  
//

import Foundation

class PostListLocalDataManager: PostListLocalDataManagerInputProtocol {

  func getPosts() -> Posts? {
    /// For some reason this user defaults implementation does not found. Ask to the technical interviewer if there are some reason
    /// ask if there is any reason why it does not work

//    if let data = UserDefaults.standard.data(forKey: "posts") {
//      do {
//        let decoder = JSONDecoder()
//        let posts = try decoder.decode(Posts.self, from: data)
//        return posts
//      } catch {
//        return nil
//      }
//    }

    return nil
  }

  func savePosts(posts: Posts) {
    do {
      let encoder = JSONEncoder()
      let data = try encoder.encode(posts)
      UserDefaults.standard.set(data, forKey: Constants.userDefaultKey)
      UserDefaults.standard.synchronize()
    } catch {
      print(error)
    }
  }
}
