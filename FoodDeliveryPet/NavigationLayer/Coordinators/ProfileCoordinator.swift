//
//  ProfileCoordinator.swift
//  FoodDeliveryPet
//
//  Created by Stanislav Shut on 27.05.2024.
//

import UIKit

class ProfileCoordinator: Coordinator {
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .black
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finish")
    }
}
