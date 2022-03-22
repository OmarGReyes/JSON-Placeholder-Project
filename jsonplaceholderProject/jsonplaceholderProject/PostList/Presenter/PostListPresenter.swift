//
//  PostListPresenter.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 17/03/22.
//  
//

import Foundation

final class PostListPresenter  {
  // MARK: Properties
  weak var view: PostListViewProtocol?
  var interactor: PostListInteractorInputProtocol?
  var wireFrame: PostListWireFrameProtocol?
  private var postList: Posts = []
  private var userInfo: User?
  private var postComments: Comments?
  private var postIdTaped: Int?
  private var postDescription: String?
  private var isFavoritePost: Bool = false

  private func presentPostDetail() {
    guard let userInfo: User = userInfo,
          let comments: Comments = postComments,
          let description: String = postDescription else { return }
    wireFrame?.presentPostDetail(from: self.view,
                                 with: PostDetail(user: userInfo,
                                                  comments: comments,
                                                  description: description,
                                                  isFavorite: isFavoritePost),
                                 delegate: self)
  }

  private func showFavorites() {
    let favorites = PostListProvider(posts: postList).favoritePosts()
    view?.updateList(posts: favorites)
  }

  private func showAll() {
    view?.updateList(posts: postList)
  }
}

extension PostListPresenter: PostListPresenterProtocol {
  func viewDidLoad() {
    interactor?.fetchList()
  }

  func didTapRow(index: Int) {
    postList = PostListProvider(posts: postList).didTapPost(index: index)
    isFavoritePost = postList[index].postInteraction.isFavorite
    postIdTaped = postList[index].id
    postDescription = postList[index].body
    interactor?.fetchUserInfo(id: postList[index].userID)
    savePostsOnLocal(posts: postList)
    view?.reloadData()
  }

  func deleteAllPosts() {
    postList = []
    view?.displayPosts(with: self.postList)
  }

  func savePostsOnLocal(posts: Posts) {
    interactor?.savePosts(posts: posts)
  }

  func refreshPosts() {
    interactor?.fetchList()
  }

  func didTapSegmentedControl(segmentIndex: Int) {
    segmentIndex == Int.zero ? showAll() : showFavorites()
  }

  func deletePostWithSwipe(postId: Int) {
    postList = PostListProvider(posts: postList).deletePost(postId: postId)
    view?.updateList(posts: postList)
  }
}

extension PostListPresenter: PostListInteractorOutputProtocol {
  func getPostsLists(with posts: Posts) {
    self.postList = posts
    view?.displayPosts(with: self.postList)
  }

  func getUserInfo(from user: User) {
    self.userInfo = user
  }

  func getComments(comments: Comments) {
    DispatchQueue.main.async { [weak self] in
      self?.postComments = comments
      self?.view?.stopSpinner()
      self?.presentPostDetail()
    }
  }

  func presentAlert(with alert: Alert) {
    self.view?.displayErrorAlert(with: alert)
  }
}

extension PostListPresenter: PostDetailViewDelegate {
  func didTapFavoriteIcon() {
    postList = PostListProvider(posts: postList).didTapFavoriteIcon(postId: postIdTaped ?? Int.zero)
    savePostsOnLocal(posts: postList)
    view?.updateList(posts: postList)
  }

  func deletePost() {
    postList = PostListProvider(posts: postList).deletePost(postId: postIdTaped ?? Int.zero)
    view?.updateList(posts: postList)
  }
}
