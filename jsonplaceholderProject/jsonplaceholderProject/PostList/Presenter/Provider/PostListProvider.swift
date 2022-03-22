//
//  PostListProvider.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 18/03/22.
//

import Foundation

final class PostListProvider {
  // MARK: - Properties
  let posts: Posts

  // MARK: - Initializer
  init(posts: Posts) {
    self.posts = posts
  }

  // MARK: - Methods
  func didTapPost(index: Int) -> Posts {
    if !posts[index].postInteraction.isFavorite {
      posts[index].postInteraction.image = Constants.noImage
      posts[index].postInteraction.wasTaped = true
    }
    return posts
  }

  func favoritePosts() -> Posts {
    let favoritePosts = posts.filter { post in
      return post.postInteraction.isFavorite
    }
    return favoritePosts
  }

  func didTapFavoriteIcon(postId: Int) -> Posts {
    if let index = posts.firstIndex(where: { post -> Bool in
      post.id == postId
    }) {
      posts[index].postInteraction.isFavorite = !posts[index].postInteraction.isFavorite
      posts[index].postInteraction.image = posts[index].postInteraction.image == Constants.favoriteImage ? Constants.noImage : Constants.favoriteImage
    }

    return posts.sorted { (post1, post2) in
      if post1.postInteraction.isFavorite == post2.postInteraction.isFavorite {
        return post1.id < post2.id
      }
      return post1.postInteraction.isFavorite && !post2.postInteraction.isFavorite
    }
  }

  func deletePost(postId: Int) -> Posts {
    if let index = posts.firstIndex(where: { post -> Bool in
      post.id == postId
    }) {
      var modifiablePost: Posts = posts
      modifiablePost.remove(at: index)
      return modifiablePost
    }
    return posts
  }
}
