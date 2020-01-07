//
//  MainNavigationController.swift
//  CSGOHackGUI
//
//  Created by Kaan Uyumaz on 15.08.2019.
//  Copyright © 2019 Kaan Uyumaz. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationController : UINavigationController
{
    var safeArea : UILayoutGuide!
    
    let label = UILabel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        
        handleColor()
        handleCustomView()
    }
    
    func handleCustomView()
    {
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -2).isActive = true
        label.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5).isActive = true
        label.widthAnchor.constraint(equalToConstant: 30).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.layer.cornerRadius = 21.5
        label.layer.backgroundColor = UIColor.gray.cgColor
    }
    
    func handleColor()
    {
        let gl = CAGradientLayer()
        gl.colors = [UIColor(red: 66/255, green: 87/255, blue: 87/255, alpha: 1).cgColor, UIColor.white.cgColor]
        gl.frame = self.view.bounds
        gl.locations = [0.0, 0.10]
        
        self.navigationBar.barTintColor = UIColor(patternImage: getImageFrom(gradientLayer: gl))
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage {
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
