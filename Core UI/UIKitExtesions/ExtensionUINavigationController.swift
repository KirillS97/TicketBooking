//
//  ExtensionUINavigationController.swift
//  Core UI
//
//  Created by Kirill on 12.01.2024.
//

import UIKit

public extension UINavigationController {
    
    // Настройка цвета navigation bar
    func setUpColors(backgroundColor: UIColor, textColor: UIColor) -> Void {
        self.navigationBar.tintColor = textColor
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: textColor]
        appearance.titleTextAttributes = [.foregroundColor: textColor]
        appearance.backgroundColor = backgroundColor
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.standardAppearance = appearance
    }
    
}
