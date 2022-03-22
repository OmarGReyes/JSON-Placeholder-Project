//
//  Comment.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 18/03/22.
//

import Foundation

// MARK: Comment
struct Comment: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

typealias Comments = [Comment]
