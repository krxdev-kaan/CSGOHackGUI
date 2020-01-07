//
//  MainViewController.swift
//  CSGOHackGUI
//
//  Created by Kaan Uyumaz on 15.08.2019.
//  Copyright © 2019 Kaan Uyumaz. All rights reserved.
//

import Foundation
import UIKit
import SwiftSocket
import ChromaColorPicker

class WallHackViewController : UIViewController
{
    var safeArea : UILayoutGuide!
    
    var wallFeature : FeatureT!
    var renderFeature : FeatureT!
    var espFeature : FeatureT!
    
    var colorPickerEnemy : ChromaColorPicker!
    var colorPickerRender : ChromaColorPicker!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView()
    {
        wallFeature = FeatureT(arg: "wall", featureName: "Wall-Hack", subFeatures: [FeatureC(arg: "wallfull", featureName: "Full-Bloom"), FeatureC(arg: "wallglow", featureName: "Glow-Only")])
        view.addSubview(wallFeature)
        wallFeature.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        wallFeature.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 2).isActive = true
        
        renderFeature = FeatureT(arg: "rendercolor", featureName: "Render-Color", subFeatures: [FeatureC(arg: "rendercolorenemy", featureName: "Enemy-Only")], colorForGrad: UIColor(red: 174/255, green: 87/255, blue: 87/255, alpha: 1.0))
        view.addSubview(renderFeature)
        renderFeature.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: -12).isActive = true
        renderFeature.topAnchor.constraint(equalTo: wallFeature.bottomAnchor, constant: 5).isActive = true
        
        espFeature = FeatureT(arg: "esp", featureName: "Visual-ESP", subFeatures: [FeatureC(arg: "espskeleton", featureName: "Skeleton-ESP"), FeatureC(arg: "esphealth", featureName: "Health-ESP"), FeatureC(arg: "espname", featureName: "Name-ESP"), FeatureC(arg: "espdebug", featureName: "Debug-ESP")], colorForGrad: UIColor(red: 87/255, green: 174/255, blue: 87/255, alpha: 1.0), manualIndexOfLongest: 0)
        view.addSubview(espFeature)
        espFeature.leadingAnchor.constraint(equalTo: renderFeature.leadingAnchor, constant: 0).isActive = true
        espFeature.topAnchor.constraint(equalTo: renderFeature.bottomAnchor, constant: 5).isActive = true
        
        colorPickerEnemy = ChromaColorPicker()
        colorPickerEnemy.delegate = self
        colorPickerEnemy.padding = 5
        colorPickerEnemy.stroke = 3
        colorPickerEnemy.hexLabel.textColor = .darkGray
        colorPickerEnemy.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(colorPickerEnemy)
        colorPickerEnemy.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 2).isActive = true
        colorPickerEnemy.centerYAnchor.constraint(equalTo: wallFeature.centerYAnchor).isActive = true
        colorPickerEnemy.widthAnchor.constraint(equalToConstant: 175).isActive = true
        colorPickerEnemy.heightAnchor.constraint(equalToConstant: 175).isActive = true
        
        colorPickerRender = ChromaColorPicker()
        colorPickerRender.delegate = self
        colorPickerRender.padding = 5
        colorPickerRender.stroke = 3
        colorPickerRender.hexLabel.textColor = .darkGray
        colorPickerRender.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(colorPickerRender)
        colorPickerRender.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 2).isActive = true
        colorPickerRender.centerYAnchor.constraint(equalTo: renderFeature.centerYAnchor).isActive = true
        colorPickerRender.widthAnchor.constraint(equalToConstant: 175).isActive = true
        colorPickerRender.heightAnchor.constraint(equalToConstant: 175).isActive = true
    }
}

extension WallHackViewController : ChromaColorPickerDelegate
{
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor)
    {
        print(colorPicker == self.colorPickerEnemy)
        switch ConnectionObj.client!.send(string: (colorPicker == self.colorPickerEnemy ? "enemycolor," : "renderercolor,") + color.hexCode) {
        case .success:
            print("ez")
            break
        case .failure:
            print("terminated")
            break
         }
    }
}
