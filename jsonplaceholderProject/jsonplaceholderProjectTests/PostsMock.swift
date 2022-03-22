//
//  PostsMock.swift
//  jsonplaceholderProjectTests
//
//  Created by Omar De Jesus Gonzalez Reyes on 21/03/22.
//

import Foundation
@testable import jsonplaceholderProject

class PostsMock {
  let post1: Post = Post(userID: 1, id: 1, title: "", body: "")
  let post2: Post = Post(userID: 2, id: 2, title: "", body: "")
  let post3: Post = Post(userID: 3, id: 3, title: "", body: "")

  func getPosts() -> Posts {
    return [post1, post2, post3]
  }
}
