//
//  ViewController.swift
//  PokeAPIApp
//
//  Created by jevania on 07/11/22.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let vc1 = UINavigationController(rootViewController: PokemonListViewController())
        let vc2 = UINavigationController(rootViewController: FavoritePokemonViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "list.bullet")
        
        vc2.tabBarItem.image = UIImage(systemName: "star")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        setViewControllers([vc1, vc2], animated: true)
    }
}

