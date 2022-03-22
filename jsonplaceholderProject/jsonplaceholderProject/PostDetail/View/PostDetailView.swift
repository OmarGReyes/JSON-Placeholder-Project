//
//  PostDetailView.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 18/03/22.
//  
//
import UIKit

// MARK: PostDetailViewDelegate
protocol PostDetailViewDelegate: AnyObject {
  func didTapFavoriteIcon()
  func deletePost()
}

// MARK: PostDetailView
final class PostDetailView: UIViewController {
  // MARK: - Outlets
  @IBOutlet weak private var postDescription: UILabel!
  @IBOutlet weak private var userName: UILabel!
  @IBOutlet weak private var userEmail: UILabel!
  @IBOutlet weak private var userPhone: UILabel!
  @IBOutlet weak private var userWebsite: UILabel!
  @IBOutlet weak private var tableView: UITableView!


  // MARK: - Properties
  var presenter: PostDetailPresenterProtocol?
  private var comments: Comments?
  weak var delegate: PostDetailViewDelegate?
  private var starIcon: String = ""

  // MARK: - Lifecycle methods
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigationBar()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.viewDidLoad()
    setupTableView()
  }

  // MARK: - Private methods
  private func setupTableView() {
//    tableView.delegate = self
    tableView.dataSource = self
  }

  private func setupNavigationBar() {
    let favoriteButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: starIcon),
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(addToFavorite))
    favoriteButton.tintColor = .systemYellow
    let trashButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.trashIcon),
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(deletePost))
    trashButton.tintColor = .systemRed
    navigationItem.rightBarButtonItems = [trashButton,favoriteButton]
  }

  @objc private func addToFavorite() {
    guard let presenter = presenter else { return }
    delegate?.didTapFavoriteIcon()
    starIcon = presenter.didTapStar(actualImage: starIcon)
    navigationItem.rightBarButtonItems?[Constants.starIconBarButtonIndex].image = UIImage(systemName: starIcon)
  }

  @objc private func deletePost() {
    displayAlert(with: .deletePost)
  }
}

// MARK: - PostDetailViewProtocol
extension PostDetailView: PostDetailViewProtocol {
  func displayInfo(with info: PostDetail) {
    userName.text = info.user.name
    userEmail.text = info.user.email
    userPhone.text = info.user.phone
    userWebsite.text = info.user.website
    postDescription.text = info.description
    comments = info.comments
    starIcon = info.isFavorite ? Constants.starFillIcon : Constants.starIcon
  }
}

// MARK: - UITableViewDelegate
//extension PostDetailView: UITableViewDelegate {
//  
//}

// MARK: - UITableViewDataSource
extension PostDetailView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return comments?.count ?? Int.zero
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.commentCellReuseIdentifier, for: indexPath)
    cell.textLabel?.text = comments?[indexPath.row].body
    cell.textLabel?.numberOfLines = Int.zero;
    cell.textLabel?.lineBreakMode = .byWordWrapping
    return cell
  }
}

// MARK: - Alertable extension
extension PostDetailView: Alertable {
  func displayAlert(with alert: Alert) {
    let deletePostAlert: UIAlertController = UIAlertController(title: alert.title,
                                                     message: alert.body,
                                                     preferredStyle: .alert)

    let deleteAction: UIAlertAction = UIAlertAction(title: alert.primaryAction, style: .default) { [weak self] (action) in
      self?.delegate?.deletePost()
      self?.presenter?.pop()
    }

    let cancelButton: UIAlertAction = UIAlertAction(title: alert.secondaryAction, style: .default, handler: nil)

    deletePostAlert.addAction(deleteAction)
    deletePostAlert.addAction(cancelButton)

    self.present(deletePostAlert, animated: true, completion: nil)
  }
}

