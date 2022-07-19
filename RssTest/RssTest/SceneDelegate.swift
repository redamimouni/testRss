//
//  SceneDelegate.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        coordinator?.displayToiletListView()
    }
}

