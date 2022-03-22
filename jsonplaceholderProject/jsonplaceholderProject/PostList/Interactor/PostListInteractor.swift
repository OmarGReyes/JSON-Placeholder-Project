//
//  PostListInteractor.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 17/03/22.
//  
//

import Foundation

final class PostListInteractor: PostListInteractorInputProtocol {
  // MARK: Properties
  weak var presenter: PostListInteractorOutputProtocol?
  var localDatamanager: PostListLocalDataManagerInputProtocol?
  var remoteDatamanager: PostListRemoteDataManagerInputProtocol?

  func fetchList() {
    if let posts: Posts = localDatamanager?.getPosts() {
      self.presenter?.getPostsLists(with: posts)
    } else {
      remoteDatamanager?.getPosts({ [weak self] result in
        switch result {
          case .success(let posts):
            self?.localDatamanager?.savePosts(posts: posts)
            self?.presenter?.getPostsLists(with: posts)
          case .failure:
            self?.presenter?.presentAlert(with: .requestError)
        }
      })
    }
  }

  func fetchUserInfo(id: Int) {
    remoteDatamanager?.getUserInfo(id: id, { [weak self] result in
      switch result {
        case .success(let user):
          self?.presenter?.getUserInfo(from: user)
          self?.fetchPostComments(postId: id)
        case .failure:
          self?.presenter?.presentAlert(with: .requestError)
      }
    })
  }

  func fetchPostComments(postId: Int) {
    remoteDatamanager?.getComments(postId: postId, { [weak self] result in
      switch result {
        case .success(let comments):
          self?.presenter?.getComments(comments: comments)
        case .failure:
          self?.presenter?.presentAlert(with: .requestError)
      }
    })
  }

  func savePosts(posts: Posts) {
    self.localDatamanager?.savePosts(posts: posts)
  }
}

extension PostListInteractor: PostListRemoteDataManagerOutputProtocol {
  // TODO: Implement use case methods
}
