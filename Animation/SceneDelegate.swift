//
//  SceneDelegate.swift
//  Animation
//
//  Created by Daniil MacBook Pro on 29.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
    
        let window = UIWindow(windowScene: scene)
        window.rootViewController = ContainerViewController()
        window.makeKeyAndVisible()
        self.window = window 
    }

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }
}

