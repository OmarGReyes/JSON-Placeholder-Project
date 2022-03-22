//
//  ProviderTests.swift
//  jsonplaceholderProjectTests
//
//  Created by Omar De Jesus Gonzalez Reyes on 21/03/22.
//

import XCTest
@testable import jsonplaceholderProject

class ProviderTests: XCTestCase {
  var sut: PostListProvider!
  var postsMock: PostsMock!

  override func setUp() {
    super.setUp()
    postsMock = PostsMock()
    sut = PostListProvider(posts: postsMock.getPosts())
  }

  override func tearDown() {
    sut = nil
    postsMock = nil
    super.tearDown()
  }

  func testDeletePost_WhenAPostWithAValidIdIsGiven_ReturnAnArrayWithOutThePost() {
    // Given
    let postId: Int = 1
    let expectedArray: Posts = [postsMock.post2, postsMock.post3]

    // When
    let posts = sut.deletePost(postId: postId)

    //Then
    XCTAssertEqual(posts[0].id, expectedArray[0].id, "The post wasn't deleted")
  }

  func testDeletePost_WhenAPostWithAnInvalidIdIsGiven_ReturnTheSameArray() {
    // Given
    let postId: Int = 5
    let expectedArray: Posts = [postsMock.post1, postsMock.post2, postsMock.post3]

    // When
    let posts = sut.deletePost(postId: postId)

    //Then
    XCTAssertEqual(posts.count, expectedArray.count, "A post was deleted")
  }

  func testDidTapFavoriteIcon_WhenAPostWithAValidIdIsGiven_ReturnAnArrayWithAFavoritePost() {
    // Given
    let postId: Int = 2

    // When
    let posts = sut.didTapFavoriteIcon(postId: postId)
    let isFavoritePost = posts[0].postInteraction.isFavorite

    // Then
    XCTAssertTrue(isFavoritePost, "Isnt's a favorite post")
  }

  func testDidTapFavoriteIcon_WhenTwoPostAreTapedAsFavorite_ReturnAnArrayWithTwoFavoritePosts() {
    // Given
    let postId1: Int = 2
    let postId2: Int = 1

    // When
    var posts: Posts = sut.didTapFavoriteIcon(postId: postId1)
    posts = sut.didTapFavoriteIcon(postId: postId2)
    let isFavoritePost1: Bool = posts[0].postInteraction.isFavorite
    let isFavoritePost2: Bool = posts[1].postInteraction.isFavorite

    // Then
    XCTAssertTrue(isFavoritePost1, "Isnt's a favorite post")
    XCTAssertTrue(isFavoritePost2, "Isn't a favorite post")
  }

  func testDidTapFavoriteIcon_WhenAPostWithAnInvalidIdIsGiven_ReturnThePostWithoutFavorites() {
    // Given
    let postId: Int = 5

    // When
    let posts: Posts = sut.didTapFavoriteIcon(postId: postId)
    let isFavoritePost: Bool = posts[0].postInteraction.isFavorite

    // Then
    XCTAssertFalse(isFavoritePost, "Is a favorite post")
  }

  func testFavoritePostFilter_WhenFunctionIsExecuted_ReturnJustFavoritePosts() {
    // Given
    let postId: Int = 1
    let posts: Posts = sut.didTapFavoriteIcon(postId: postId)

    // When
    let newSutWithFavorite: PostListProvider = PostListProvider(posts: posts)
    let containsAnyFalse: Bool = newSutWithFavorite.favoritePosts().contains { (post) in
      !post.postInteraction.isFavorite
    }

    // Then
    XCTAssertFalse(containsAnyFalse)
  }

  func testDidTapPost_WhenAValidIdIsGiven_ReturnAnArrayWithAPostTaped() {
    // Given
    let postIndex: Int = 0

    // When
    let postsTaped: Posts = sut.didTapPost(index: postIndex)

    // Then
    XCTAssertEqual(postsTaped[postIndex].postInteraction.image, "noImage")
  }
}
