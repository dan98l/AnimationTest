//
//  ContainerViewController.swift
//  Animation
//
//  Created by Daniil MacBook Pro on 29.02.2024.
//

import UIKit

final class ContainerViewController: UIViewController {
    
    private var navController: UINavigationController?
    private var menuViewController: MenuViewController!
    private var homeViewController: HomeViewController!

    private var menuState: MenuState = .closed

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        setupViewControllers()
        showMenuViewControllers()
        showHomeViewControllers()
    }
    
    private func setupViewControllers() {
        homeViewController = HomeViewController(delegate: self)
        menuViewController = MenuViewController(delegate: self)
    }
    
    private func showHomeViewControllers() {
        navController = UINavigationController(rootViewController: homeViewController)
        
        guard let navigationController = navController else { return }
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
    }
    
    private func showMenuViewControllers() {
        addChild(menuViewController)
        view.addSubview(menuViewController.view)
        menuViewController.didMove(toParent: self)
    }
    
    private func animationMenu(menuState: MenuState) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.0,
            animations: {
                let originX = menuState == .closed ? 0.0 : self.homeViewController.view.frame.width - 100
                self.navController?.view.frame.origin.x = originX
            },
            completion: { done in
                self.menuState = menuState
            }
        )
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        switch menuState {
        case .closed:
            animationMenu(menuState: .opened)
        case .opened:
            animationMenu(menuState: .closed)
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuOptions) {
        homeViewController.animations(option: menuItem)
        animationMenu(menuState: .closed)
    }
}
