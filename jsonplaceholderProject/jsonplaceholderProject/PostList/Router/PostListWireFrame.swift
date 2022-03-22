//
//  PostListWireFrame.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 17/03/22.
//  
//

import UIKit

final class PostListWireFrame: PostListWireFrameProtocol {

  static func createPostListModule() -> UIViewController {
    let navController = mainStoryboard.instantiateViewController(withIdentifier: Constants.navigationViewControllerIdentifier)
    if let view = navController.children.first as? PostListView {
      let presenter: PostListPresenterProtocol & PostListInteractorOutputProtocol = PostListPresenter()
      let interactor: PostListInteractorInputProtocol & PostListRemoteDataManagerOutputProtocol = PostListInteractor()
      let localDataManager: PostListLocalDataManagerInputProtocol = PostListLocalDataManager()
      let remoteDataManager: PostListRemoteDataManagerInputProtocol = PostListRemoteDataManager()
      let wireFrame: PostListWireFrameProtocol = PostListWireFrame()

      view.presenter = presenter
      presenter.view = view
      presenter.wireFrame = wireFrame
      presenter.interactor = interactor
      interactor.presenter = presenter
      interactor.localDatamanager = localDataManager
      interactor.remoteDatamanager = remoteDataManager
      remoteDataManager.remoteRequestHandler = interactor

      return navController
    }
    return UIViewController()
  }

  static var mainStoryboard: UIStoryboard {
    return UIStoryboard(name: Constants.postListStoryBoardName, bundle: Bundle.main)
  }

  // MARK: - methods
  func presentPostDetail(from view: PostListViewProtocol?, with postDetail: PostDetail, delegate: PostListPresenterProtocol) {
    let newDetailView = PostDetailWireFrame.createPostDetailModule(with: postDetail, delegate: delegate)
    if let newView = view as? UIViewController {
      newView.navigationController?.pushViewController(newDetailView, animated: true)
    }
  }
}
