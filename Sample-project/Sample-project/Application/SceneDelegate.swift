//
//  SceneDelegate.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/07.
//

import UIKit
import RxFlow

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let coordinator: FlowCoordinator = .init()


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let provider = ServiceProvider()
        
        let appFlow = AppFlow(withWindow: window, and: provider)
        let appStepper = AppStepper(provider: provider)
        
        coordinator.coordinate(flow: appFlow, with: appStepper)
        
        window.makeKeyAndVisible()
        
    }



}

