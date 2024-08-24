//
//  UIViewController+NavigationController.swift
//  Nushift_Test
//
//  Created by SREEKANTH on 24/08/24.
//

import Foundation
import UIKit

extension UIViewController {
    func setupNavBar(_ controller: UIViewController) {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.black
            appearance.shadowColor = UIColor.clear
            appearance.shadowImage = UIImage()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            controller.navigationController?.navigationBar.standardAppearance = appearance
            controller.navigationController?.navigationBar.compactAppearance = appearance
            controller.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            controller.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)]
        }
    }
}
