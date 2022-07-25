//
//  Coordinator.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import UIKit

protocol Coordinated where Self: UIViewController {
    func bindWith(coordinator: MainCoordinator)
}

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func displayToiletListView()
}

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func displayToiletListView() {
        let repository = ToiletListRepositoryImpl()
        let useCase = ToiletListUseCaseImpl(repository: repository)
        let locationManager = LocationManager()
        let presenter = ToiletListPresenter(useCase: useCase, locationManager: locationManager)
        let viewController = ToiletListViewController(presenter: presenter)
        viewController.bindWith(coordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }

    func displayToiletDetailView() {
        
    }
}
