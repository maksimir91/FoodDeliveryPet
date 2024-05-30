//
//  OnboardingCoordinator.swift
//  FoodDeliveryPet
//
//  Created by Stanislav Shut on 27.05.2024.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    override func start() {
        showOnboarding()
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}

private extension OnboardingCoordinator {
    func showOnboarding() {
        var pages = [UIViewController]()
        let firstVC = UIViewController()
        firstVC.view.backgroundColor = .purple
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .yellow
        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = .red
        let forthVC = UIViewController()
        forthVC.view.backgroundColor = .blue
        pages.append(firstVC)
        pages.append(secondVC)
        pages.append(thirdVC)
        pages.append(forthVC)
        let presenter = OnboardingViewPresenter(coordinator: self)
        let viewController = OnboardingViewController(pages: pages, viewOutPut: presenter)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

