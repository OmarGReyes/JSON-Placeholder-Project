//
//  PostDetailPresenter.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 18/03/22.
//  
//

import Foundation

final class PostDetailPresenter  {

  // MARK: Properties
  weak var view: PostDetailViewProtocol?
  var wireFrame: PostDetailWireFrameProtocol?
  var postDetail: PostDetail

  init(postDetail: PostDetail) {
    self.postDetail = postDetail
  }

}

extension PostDetailPresenter: PostDetailPresenterProtocol {
  func viewDidLoad() {
    view?.displayInfo(with: postDetail)
  }

  func didTapStar(actualImage: String) -> String {
    return actualImage == Constants.starIcon ? Constants.starFillIcon : Constants.starIcon
  }

  func pop() {
    wireFrame?.pop(from: self.view)
  }
}
