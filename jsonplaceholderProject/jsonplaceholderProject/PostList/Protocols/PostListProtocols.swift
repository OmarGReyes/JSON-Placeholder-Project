//
//  PostListProtocols.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 17/03/22.
//  
//

import UIKit

protocol Alertable: UIViewController {
  func displayAlert(with alert: Alert)
}

protocol PostListViewProtocol: AnyObject {
  var presenter: PostListPresenterProtocol? { get set }
  func displayPosts(with posts: Posts)
  func reloadData()
  func updateList(posts: Posts)
  func displayErrorAlert(with alert: Alert)
  func stopSpinner()
}

protocol PostListWireFrameProtocol: AnyObject {
  static func createPostListModule() -> UIViewController
  func presentPostDetail(from view: PostListViewProtocol?, with postDetail: PostDetail, delegate: PostListPresenterProtocol)
}

protocol PostListPresenterProtocol: PostDetailViewDelegate {
  var view: PostListViewProtocol? { get set }
  var interactor: PostListInteractorInputProtocol? { get set }
  var wireFrame: PostListWireFrameProtocol? { get set }
  
  func viewDidLoad()
  func didTapRow(index: Int)
  func deleteAllPosts()
  func refreshPosts()
  func didTapSegmentedControl(segmentIndex: Int)
  func deletePostWithSwipe(postId: Int)
}

protocol PostListInteractorOutputProtocol: AnyObject {
  func getPostsLists(with posts: Posts)
  func getUserInfo(from user: User)
  func getComments(comments: Comments)
  func presentAlert(with alert: Alert)
}

protocol PostListInteractorInputProtocol: AnyObject {
  var presenter: PostListInteractorOutputProtocol? { get set }
  var localDatamanager: PostListLocalDataManagerInputProtocol? { get set }
  var remoteDatamanager: PostListRemoteDataManagerInputProtocol? { get set }

  func fetchList()
  func fetchUserInfo(id: Int)
  func fetchPostComments(postId: Int)
  func savePosts(posts: Posts)
}

protocol PostListDataManagerInputProtocol: AnyObject {

}

protocol PostListRemoteDataManagerInputProtocol: AnyObject {
  var remoteRequestHandler: PostListRemoteDataManagerOutputProtocol? { get set }
  func getPosts(_ completion: @escaping (Result<Posts, Error>) -> Void)
  func getUserInfo(id: Int, _ completion: @escaping (Result<User, Error>) -> Void)
  func getComments(postId: Int,_ completion: @escaping (Result<Comments, Error>) -> Void)
}

protocol PostListRemoteDataManagerOutputProtocol: AnyObject {

}

protocol PostListLocalDataManagerInputProtocol: AnyObject {
  func getPosts() -> Posts?
  func savePosts(posts: Posts)
}
