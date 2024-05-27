//
//  OnboardingCoordinator.swift
//  FoodDeliveryPet
//
//  Created by Stanislav Shut on 27.05.2024.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    override func start() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}


