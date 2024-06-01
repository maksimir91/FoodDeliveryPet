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
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

private extension OnboardingCoordinator {
    func showOnboarding() {
        var pages = [OnboardingPartViewController]()
        let firstVC = OnboardingPartViewController()
        firstVC.imageToShow = UIImage(resource: .chickenLeg1)
        firstVC.titleText = "Delicious Food"
        firstVC.descriptionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        firstVC.buttonText = "Next"
        
        let secondVC = OnboardingPartViewController()
        secondVC.imageToShow = UIImage(resource: .shipped1)
        secondVC.titleText = "Fast Shipping"
        secondVC.descriptionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Interdum rhoncus nulla."
        secondVC.buttonText = "Next"
        
        let thirdVC = OnboardingPartViewController()
        thirdVC.imageToShow = UIImage(resource: .medal1)
        thirdVC.titleText = "Certificate Food"
        thirdVC.descriptionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ultricies mauris a id."
        thirdVC.buttonText = "Next"
        
        let forthVC = OnboardingPartViewController()
        forthVC.imageToShow = UIImage(resource: .creditCard1)
        forthVC.titleText = "Payment Online"
        forthVC.descriptionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dui ultricies sit massa."
        forthVC.buttonText = "Cool!"
        
        pages.append(firstVC)
        pages.append(secondVC)
        pages.append(thirdVC)
        pages.append(forthVC)
        let presenter = OnboardingViewPresenter(coordinator: self)
        let viewController = OnboardingViewController(pages: pages, viewOutPut: presenter)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

