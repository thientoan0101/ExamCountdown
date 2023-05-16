//
//  SceneDelegate.swift
//  ExamCountdown
//
//  Created by Toan Thien on 16/05/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        // init view controller
        let countdownVC = CountdownViewController()
        let countdownNavi = UINavigationController(rootViewController: countdownVC)
        countdownVC.tabBarItem = UITabBarItem(title: "Đếm ngược", image: UIImage(systemName: "timer"), tag: 0)
        
        let eventVC = EventViewController()
        let eventNavi = UINavigationController(rootViewController: eventVC)
        eventVC.tabBarItem = UITabBarItem(title: "Sự kiện", image: UIImage(systemName: "calendar.circle"), selectedImage: UIImage(systemName: "calendar.circle.fill"))
        
        
        let tabbarVC = UITabBarController()
        tabbarVC.viewControllers = [countdownNavi, eventNavi]
        tabbarVC.tabBar.backgroundColor = UIColor.white
        tabbarVC.tabBar.layer.shadowColor = UIColor.gray.cgColor
        
        tabbarVC.tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabbarVC.tabBar.layer.shadowRadius = 6
        tabbarVC.tabBar.layer.shadowOpacity = 0.3
        tabbarVC.tabBar.layer.masksToBounds = false
        
        
        // Create a gradient layer
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.blue.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        // Customize the navigation bar appearance
        let appearance = UINavigationBarAppearance()
//        appearance.backgroundImage = gradientLayer.createGradientImage()
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64), fromColor: UIColor(hex: "#FF0085FF")?.cgColor ?? UIColor.blue.cgColor, toColor: UIColor(hex: "#FF00ACF4")?.cgColor ?? UIColor.white.cgColor)
        let backgroundImage = gradientView.asImage()
        appearance.backgroundImage = backgroundImage
        
        // Apply the appearance to all navigation bars
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        window.rootViewController = tabbarVC
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

