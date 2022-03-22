//
//  AppDelegate.swift
//  jsonplaceholderProject
//
//  Created by Omar De Jesus Gonzalez Reyes on 17/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  // MARK: - Methods
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let postListView = PostListWireFrame.createPostListModule()
    self.window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = postListView
    window?.makeKeyAndVisible()
    return true
   }

  func applicationWillTerminate(_ application: UIApplication) {
    // TODO: - Add some method here to storage the post list state
  }
}

