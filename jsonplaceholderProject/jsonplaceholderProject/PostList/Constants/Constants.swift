//
//  Constants.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 21/03/22.
//

import Foundation

// MARK: Constants
struct Constants {
  static let postCellReuseIdentifier = "postCell"
  static let commentCellReuseIdentifier = "commentCell"
  static let deleteSwipeAction = "Delete"
  static let userDefaultKey = "posts"
  static let postsURL = "https://jsonplaceholder.typicode.com/posts"
  static let userURL = "https://jsonplaceholder.typicode.com/users/"
  static let commentsURLFirstPart = "https://jsonplaceholder.typicode.com/posts/"
  static let commentsURLSecondPart = "/comments"
  static let navigationViewControllerIdentifier = "navigation"
  static let postListStoryBoardName = "PostListView"
  static let postDetailViewControllerIdentifier = "PostDetailView"
  static let postDetailStoryBoardName = "PostDetailView"
  static let starIconBarButtonIndex = 1

  // MARK: - Image constants
  static let nonReadImage = "nonRead"
  static let goForwardImage = "goforward"
  static let noImage = "noImage"
  static let favoriteImage = "favorite"
  static let starIcon = "star"
  static let starFillIcon = "star.fill"
  static let trashIcon = "trash"

  // MARK: - Alerts constants
  static let deletePostTitle = "Delete post"
  static let deleteAllPostsTitle = "Delete all post"
  static let refreshViewTitle = "Refresh view"
  static let requestErrorTitle = "Request Error"

  static let deletePostBody = "Do you want to delete this post?"
  static let deleteAllPostBody = "Do you want to delete all posts?"
  static let refreshViewBody = "Do you want to refresh the view?\nYou will lose all your favorite posts"
  static let requestErrorBody = "we are experiencing some problems"

  static let deletePrimaryAction = "Delete"
  static let refreshViewPrimaryAction = "Refresh"
  static let requestErrorPrimaryAction = "Accept"
  static let cancelSecondaryAction = "Cancel"
}
