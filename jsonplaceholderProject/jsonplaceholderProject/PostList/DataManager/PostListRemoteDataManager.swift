//
//  PostListRemoteDataManager.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 17/03/22.
//  
//

import Foundation

// MARK: PostListRemoteDataManager Class
class PostListRemoteDataManager:PostListRemoteDataManagerInputProtocol {

  // MARK: - Properties
  var remoteRequestHandler: PostListRemoteDataManagerOutputProtocol?

  // MARK: - getPosts method
  func getPosts(_ completion: @escaping (Result<Posts, Error>) -> Void) {
    // MARK: - URLSession configuration
    let sessionConfiguration: URLSessionConfiguration = .default
    let session: URLSession = URLSession(configuration: sessionConfiguration)
    let baseURL: String = Constants.postsURL

    // MARK: - URLSession request
    if let url: URL = URL(string: baseURL) {
      let request: URLRequest = URLRequest(url: url)
      let dataTask: URLSessionTask = session.dataTask(with: request) {
        (data, response, error) in
        guard let data = data, let dataJson: Posts = try? JSONDecoder().decode(Posts.self, from: data) else { return }
        if let error = error {
          completion(.failure(error))
          return
        }
        completion(.success(dataJson))
      }
      dataTask.resume()
    }
  }

  // MARK: - getUserInfo method
  func getUserInfo(id: Int, _ completion: @escaping (Result<User, Error>) -> Void) {
    // MARK: - URLSession configuration
    let sessionConfiguration: URLSessionConfiguration = .default
    let session: URLSession = URLSession(configuration: sessionConfiguration)
    let baseURL: String = "\(Constants.userURL)\(id)"

    // MARK: - URLSession request
    if let url: URL = URL(string: baseURL) {
      let request: URLRequest = URLRequest(url: url)
      let dataTask: URLSessionTask = session.dataTask(with: request) {
        (data, response, error) in
        guard let data = data, let dataJson: User = try? JSONDecoder().decode(User.self, from: data) else { return }
        if let error = error {
          completion(.failure(error))
          return
        }
        completion(.success(dataJson))
      }
      dataTask.resume()
    }
  }

  // MARK: - getComments method
  func getComments(postId: Int,_ completion: @escaping (Result<Comments, Error>) -> Void) {
    // MARK: - URLSession configuration
    let sessionConfiguration: URLSessionConfiguration = .default
    let session: URLSession = URLSession(configuration: sessionConfiguration)
    let baseURL: String = "\(Constants.commentsURLFirstPart)\(postId)\(Constants.commentsURLSecondPart)"

    // MARK: - URLSession request
    if let url: URL = URL(string: baseURL) {
      let request: URLRequest = URLRequest(url: url)
      let dataTask: URLSessionTask = session.dataTask(with: request) {
        (data, response, error) in
        guard let data = data, let dataJson: Comments = try? JSONDecoder().decode(Comments.self, from: data) else { return }
        if let error = error {
          completion(.failure(error))
          return
        }
        completion(.success(dataJson))
      }
      dataTask.resume()
    }
  }
}
