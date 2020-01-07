//
//  AimHackViewController.swift
//  CSGOHackGUI
//
//  Created by Kaan Uyumaz on 19.08.2019.
//  Copyright © 2019 Kaan Uyumaz. All rights reserved.
//

import Foundation
import UIKit

class AimHackViewController : UIViewController
{
    
    var safeArea : UILayoutGuide!
    
    var aimFeatures : FeatureT!
    var aimFeatureLeadingCons : NSLayoutConstraint!
    var triggerFeature : FeatureT!
    var triggerFeatureLeadingCons : NSLayoutConstraint!
    var container : UIView!
    var labelHead : UILabel!
    var labelBody : UILabel!
    var selectorToggle : UISwitch!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        aimFeatures = FeatureT(arg: "aim", featureName: "Aim-Hack", subFeatures: [FeatureC(arg: "aimrecoil", featureName: "Anti-Recoil"), FeatureC(arg: "aimtrigger", featureName: "Shoot-On-Collide"), FeatureC(arg: "aimsilent", featureName: "Silent-Aim"), FeatureC(arg: "aimautobot", featureName: "Auto-Bot")], manualIndexOfLongest: 1)
        view.addSubview(aimFeatures)
        aimFeatureLeadingCons = aimFeatures.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5)
        aimFeatureLeadingCons.isActive = true
        aimFeatures.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5).isActive = true
        
        labelHead = UILabel()
        labelBody = UILabel()
        selectorToggle = UISwitch()
        container = UIView()
        
        labelHead.text = "Hitbox-Head"
        labelHead.font = UIFont(name: "Copperplate-Light", size: 15.5)
        
        labelBody.text = "Hitbox-Body"
        labelBody.font = UIFont(name: "Copperplate-Light", size: 15.5)
        
        selectorToggle.tintColor = .clear
        selectorToggle.onTintColor = .clear
        selectorToggle.layer.cornerRadius = 12.5
        selectorToggle.layer.backgroundColor = UIColor.black.cgColor
        selectorToggle.addTarget(self, action: #selector(sendPacket), for: .valueChanged)
        
        labelHead.translatesAutoresizingMaskIntoConstraints = false
        labelBody.translatesAutoresizingMaskIntoConstraints = false
        selectorToggle.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(container)
        container.topAnchor.constraint(equalTo: aimFeatures.bottomAnchor, constant: 5).isActive = true
        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        container.addSubview(selectorToggle)
        selectorToggle.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        container.addSubview(labelHead)
        labelHead.topAnchor.constraint(equalTo: container.topAnchor, constant: 5).isActive = true
        selectorToggle.topAnchor.constraint(equalTo: labelHead.bottomAnchor, constant: 2).isActive = true
        labelHead.trailingAnchor.constraint(equalTo: selectorToggle.leadingAnchor, constant: 5).isActive = true
        
        container.addSubview(labelBody)
        labelBody.topAnchor.constraint(equalTo: selectorToggle.bottomAnchor, constant: 2).isActive = true
        labelBody.leadingAnchor.constraint(equalTo: selectorToggle.trailingAnchor, constant: -5).isActive = true
        
        container.leadingAnchor.constraint(equalTo: labelHead.leadingAnchor, constant: -5).isActive = true
        container.trailingAnchor.constraint(equalTo: labelBody.trailingAnchor, constant: 5).isActive = true
        container.bottomAnchor.constraint(equalTo: labelBody.bottomAnchor, constant: 5).isActive = true
        
        triggerFeature = FeatureT(arg: "trigger", featureName: "Trigger-Bot", subFeatures: [FeatureC(arg: "triggerpress", featureName: "Only-On-Press")], colorForGrad: UIColor(red: 87/255, green: 174/255, blue: 87/255, alpha: 1.0))
        view.addSubview(triggerFeature)
        triggerFeatureLeadingCons = triggerFeature.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5)
        triggerFeatureLeadingCons.isActive = true
        triggerFeature.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 5).isActive = true
    }
    
    override func viewDidLayoutSubviews()
    {
        var result : CGFloat = view.frame.midX - aimFeatures.frame.midX
        aimFeatureLeadingCons.isActive = false
        aimFeatureLeadingCons = aimFeatures.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5 + result)
        aimFeatureLeadingCons.isActive = true
        
        var resultTrigger : CGFloat = view.frame.midX - triggerFeature.frame.midX
        triggerFeatureLeadingCons.isActive = false
        triggerFeatureLeadingCons = triggerFeature.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5 + resultTrigger)
        triggerFeatureLeadingCons.isActive = true
        
        let gl = CAGradientLayer()
        gl.colors = [UIColor.white.cgColor, UIColor(red: 66*2/255, green: 87*2/255, blue: 87*2/255, alpha: 1).cgColor, UIColor.white.cgColor]
        gl.frame = container.bounds
        gl.locations = [0.1, 0.5, 0.9]
        gl.startPoint = .init(x: 0.0, y: 0.0)
        gl.endPoint = .init(x: 1.0, y: 1.0)
        
        container.layer.cornerRadius = 18.5
        container.backgroundColor = UIColor(patternImage: MainNavigationController().getImageFrom(gradientLayer: gl))
    }
    
    @objc func sendPacket()
    {
        switch ConnectionObj.client!.send(string: "aimpos" + "," + (selectorToggle.isOn ? "body" : "head")) {
        case .success:
            print("ez")
            break
        case .failure:
            print("terminated")
            break
        }
    }
    
}
