//
//  Post.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 17/03/22.
//

import Foundation

// MARK: Post
struct Post: Codable {
  let userID, id: Int
  let title, body: String
  let postInteraction: PostInteraction = PostInteraction()

  enum CodingKeys: String, CodingKey {
    case userID = "userId"
    case id, title, body, postInteraction
  }
}

final class PostInteraction: Codable {
  var isFavorite: Bool = false
  var wasTaped: Bool = false
  var image: String = Constants.nonReadImage
}

typealias Posts = [Post]
