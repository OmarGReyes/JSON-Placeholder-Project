//
//  AlertHelper.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 21/03/22.
//

import Foundation

// MARK: Alert
enum Alert {
  case deletePost
  case deleteAllPosts
  case refreshView
  case requestError
  case refreshFromButton

  var title: String {
    switch self {
      case .deletePost:
        return Constants.deletePostTitle
      case .deleteAllPosts:
        return Constants.deleteAllPostsTitle
      case .refreshView, .refreshFromButton:
        return Constants.refreshViewTitle
      case .requestError:
        return Constants.requestErrorTitle
    }
  }

  var body: String {
    switch self {
      case .deletePost:
        return Constants.deletePostBody
      case .deleteAllPosts:
        return Constants.deleteAllPostBody
      case .refreshView, .refreshFromButton:
        return Constants.refreshViewBody
      case .requestError:
        return Constants.requestErrorBody
    }
  }

  var primaryAction: String {
    switch self {
      case .deletePost, .deleteAllPosts:
        return Constants.deletePrimaryAction
      case .refreshView, .refreshFromButton:
        return Constants.refreshViewPrimaryAction
      case .requestError:
        return Constants.requestErrorPrimaryAction
    }
  }

  var secondaryAction: String {
    return Constants.cancelSecondaryAction
  }
}
