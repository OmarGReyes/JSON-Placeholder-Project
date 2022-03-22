//
//  PostListView.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 17/03/22.
//  
//
import UIKit

final class PostListView: UIViewController {
  // MARK: - Properties
  var presenter: PostListPresenterProtocol?
  private var postList: Posts?
  private var swipedCell: Int = .zero

  // MARK: - IBOutlets
  @IBOutlet weak private var tableView: UITableView!
  @IBOutlet weak private var spinner: UIActivityIndicatorView!

  // MARK: - Lifecycle methods

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupRefreshControl()
    setupSpinner()
    presenter?.viewDidLoad()
  }

  // MARK: - Private methods
  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.goForwardImage), style: .plain, target: self, action: #selector(refreshButton))
    navigationItem.rightBarButtonItem = rightButton
  }

  private func setupSpinner() {
    spinner.hidesWhenStopped = true
    spinner.color = .systemBlue
    spinner.center = view.center
    spinner.startAnimating()
  }

  private func startSpinnerAnimation() {
    DispatchQueue.main.async { [weak self] in
      self?.spinner.startAnimating()
    }
  }

  private func setupRefreshControl() {
    let refreshControl: UIRefreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }

  @objc private func refreshButton() {
    displayAlert(with: .refreshFromButton)
  }

  @objc private func refreshAction() {
    displayAlert(with: .refreshView)
  }

  // MARK: - IBActions
  @IBAction private func didTapDeleteAllButton(_ sender: UIButton) {
    displayAlert(with: .deleteAllPosts)
  }

  @IBAction private func didTapSegmentedControl(_ sender: UISegmentedControl) {
    presenter?.didTapSegmentedControl(segmentIndex: sender.selectedSegmentIndex)
  }

}

// MARK: - PostViewProtocol extension
extension PostListView: PostListViewProtocol {
  func displayPosts(with posts: Posts) {
    DispatchQueue.main.async { [weak self] in
      self?.postList = posts
      self?.reloadData()
    }
  }

  func reloadData() {
    spinner.stopAnimating()
    tableView.reloadData()
  }

  func updateList(posts: Posts) {
    postList = posts
    reloadData()
  }

  func displayErrorAlert(with alert: Alert) {
    displayAlert(with: .requestError)
  }

  func stopSpinner() {
    DispatchQueue.main.async { [weak self] in
      self?.spinner.stopAnimating()
    }
  }
}

// MARK: - UITableViewDataSource extension
extension PostListView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postList?.count ?? .zero
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let post: Post = postList?[indexPath.row],
          let cell: PostCell = self.tableView.dequeueReusableCell(withIdentifier: Constants.postCellReuseIdentifier, for: indexPath) as? PostCell else {
      return UITableViewCell()
    }

    cell.cellText?.text = post.title
    cell.cellImage?.image = UIImage(named: post.postInteraction.image)
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    startSpinnerAnimation()
    presenter?.didTapRow(index: indexPath.row)
  }
}

// MARK: - UITableViewDelegate extension
extension PostListView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action: UIContextualAction = UIContextualAction(style: .destructive, title: Constants.deleteSwipeAction) { [weak self] (action, view, completion) in
      self?.swipedCell = indexPath.row
      self?.displayAlert(with: .deletePost)
    }

    return UISwipeActionsConfiguration(actions: [action])
  }
}

// MARK: - Alertable extension
extension PostListView: Alertable {

  func displayAlert(with alert: Alert) {
    let alertScreen: UIAlertController = UIAlertController(title: alert.title,
                                                         message: alert.body,
                                                     preferredStyle: .alert)

    let primaryAction: UIAlertAction = UIAlertAction(title: alert.primaryAction, style: .default) { [weak self] _ in
      guard let self = self else { return }
      switch alert {
        case .deleteAllPosts:
          self.presenter?.deleteAllPosts()
        case .refreshView:
          self.presenter?.refreshPosts()
          self.tableView.refreshControl?.endRefreshing()
        case .deletePost:
          self.presenter?.deletePostWithSwipe(postId: self.postList?[self.swipedCell].id ?? Int.zero)
        case .refreshFromButton:
          self.startSpinnerAnimation()
          self.presenter?.refreshPosts()
        case .requestError:
          return
      }
    }

    let secondaryAction: UIAlertAction = UIAlertAction(title: alert.secondaryAction, style: .default) { [weak self] _ in
      switch alert {
        case .refreshView:
          self?.tableView.refreshControl?.endRefreshing()
        default:
          return
      }
    }

    alertScreen.addAction(primaryAction)
    switch alert {
      case .requestError:
        break
      default:
        alertScreen.addAction(secondaryAction)
    }

    self.present(alertScreen, animated: true, completion: nil)
  }
}
