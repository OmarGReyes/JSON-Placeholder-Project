//
//  PostDetailProtocols.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 18/03/22.
//  
//

import UIKit

protocol PostDetailViewProtocol: AnyObject {
  var presenter: PostDetailPresenterProtocol? { get set }
  func displayInfo(with info: PostDetail)
  var delegate: PostDetailViewDelegate? { get set }
}

protocol PostDetailWireFrameProtocol: AnyObject {
  static func createPostDetailModule(with model: PostDetail, delegate: PostListPresenterProtocol) -> UIViewController
  func pop(from viewController: PostDetailViewProtocol?)
}

protocol PostDetailPresenterProtocol: AnyObject {
  var view: PostDetailViewProtocol? { get set }
  var wireFrame: PostDetailWireFrameProtocol? { get set }

  func viewDidLoad()
  func didTapStar(actualImage: String) -> String
  func pop()
}
