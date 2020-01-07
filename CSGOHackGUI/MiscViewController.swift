//
//  MiscViewController.swift
//  CSGOHackGUI
//
//  Created by Kaan Uyumaz on 15.08.2019.
//  Copyright © 2019 Kaan Uyumaz. All rights reserved.
//

import Foundation
import UIKit
import SwiftSocket

class MiscViewController : UIViewController
{
    
    var safeArea : UILayoutGuide!
    
    var antiFlashFeature : FeatureT!
    var antiFlashFeatureLeadingCons : NSLayoutConstraint!
    var bunnyHopFeature : FeatureT!
    var bunnyHopFeatureLeadingCons : NSLayoutConstraint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        antiFlashFeature = FeatureT(arg: "antiflash", featureName: "Anti-Flash")
        antiFlashFeature.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(antiFlashFeature)
        
        antiFlashFeature.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true
        antiFlashFeatureLeadingCons = antiFlashFeature.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5)
        antiFlashFeatureLeadingCons.isActive = true
        
        bunnyHopFeature = FeatureT(arg: "bunnyhop", featureName: "Bunny-Hop")
        bunnyHopFeature.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bunnyHopFeature)
        
        bunnyHopFeature.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true
        bunnyHopFeatureLeadingCons = bunnyHopFeature.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5)
        bunnyHopFeatureLeadingCons.isActive = true
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        var result : CGFloat = view.frame.midX - antiFlashFeature.frame.midX
        
        antiFlashFeatureLeadingCons.isActive = false
        antiFlashFeatureLeadingCons = antiFlashFeature.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5 + result)
        antiFlashFeatureLeadingCons.isActive = true
        
        var resultBunny : CGFloat = view.frame.midX - bunnyHopFeature.frame.midX
        
        bunnyHopFeatureLeadingCons.isActive = false
        bunnyHopFeatureLeadingCons = bunnyHopFeature.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5 + resultBunny)
        bunnyHopFeatureLeadingCons.isActive = true
    }
    
}
