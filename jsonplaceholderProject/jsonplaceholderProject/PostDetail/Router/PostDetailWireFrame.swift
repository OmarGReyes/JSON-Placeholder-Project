//
//  PostDetailWireFrame.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 18/03/22.
//  
//

import UIKit

final class PostDetailWireFrame: PostDetailWireFrameProtocol {

  static func createPostDetailModule(with model: PostDetail, delegate: PostListPresenterProtocol) -> UIViewController {
    let viewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.postDetailViewControllerIdentifier)
    if let view = viewController as? PostDetailView {
      let presenter: PostDetailPresenterProtocol = PostDetailPresenter(postDetail: model)
      let wireFrame: PostDetailWireFrameProtocol = PostDetailWireFrame()

      view.presenter = presenter
      view.delegate = delegate
      presenter.view = view
      presenter.wireFrame = wireFrame

      return view
    }
    return UIViewController()
  }

  static var mainStoryboard: UIStoryboard {
    return UIStoryboard(name: Constants.postDetailStoryBoardName, bundle: Bundle.main)
  }

  func pop(from viewController: PostDetailViewProtocol?) {
    guard let viewController: UIViewController = viewController as? UIViewController else { return }
    viewController.navigationController?.popViewController(animated: true)
  }
}
