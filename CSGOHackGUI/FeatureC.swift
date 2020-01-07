//
//  FeatureC.swift
//  CSGOHackGUI
//
//  Created by Kaan Uyumaz on 15.08.2019.
//  Copyright © 2019 Kaan Uyumaz. All rights reserved.
//

import Foundation
import UIKit

class FeatureT : UIView
{
    var cons = false
    
    var label : UILabel!
    var toggle : UISwitch!
    var state : UILabel!
    
    var layerS : CAShapeLayer!
    
    var args : String!
    var colorOfGrad : UIColor!
    var childFeatures : [FeatureC]?
    var manualIndex : Int?
    
    public init (arg: String, featureName: String, subFeatures: [FeatureC]? = nil, colorForGrad : UIColor? = nil, manualIndexOfLongest : Int? = nil) {
        super.init(frame : CGRect.zero)
//        self.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
        
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        args = arg
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = featureName
        toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        state = UILabel()
        state.translatesAutoresizingMaskIntoConstraints = false
        layerS = CAShapeLayer()
        layerS.lineWidth = 2
        layerS.strokeColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        layerS.fillColor = nil
        layerS.frame = self.bounds
        self.layer.addSublayer(layerS)
        
        self.addSubview(label)
        self.addSubview(toggle)
        self.addSubview(state)
        
        if subFeatures != nil
        {
            childFeatures = subFeatures!
        }
        
        if colorForGrad != nil
        {
            colorOfGrad = colorForGrad
        }
        
        if manualIndexOfLongest != nil
        {
            manualIndex = manualIndexOfLongest
        }
        
        layer.cornerRadius = 18.5
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleGradient()
    {
        let gl = CAGradientLayer()
        gl.colors = [UIColor.white.cgColor, colorOfGrad != nil ? colorOfGrad.cgColor : UIColor(red: 66*2/255, green: 87*2/255, blue: 87*2/255, alpha: 1).cgColor, UIColor.white.cgColor]
        gl.frame = self.bounds
        gl.locations = [0.1, 0.5, 0.9]
        gl.startPoint = .init(x: 0.0, y: 0.0)
        gl.endPoint = .init(x: 1.0, y: 1.0)
        
        DispatchQueue.main.async
        {
            self.backgroundColor = UIColor(patternImage: MainNavigationController().getImageFrom(gradientLayer: gl))
        }
    }
    
    @objc func sendPacket()
    {
        switch ConnectionObj.client!.send(string: args + "," + (toggle.isOn ? "on" : "off")) {
        case .success:
            print("ez")
            break
        case .failure:
            print("terminated")
            break
        }
    }
    
    override func draw(_ rect: CGRect)
    {
        handleGradient()
        if childFeatures != nil
        {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: state.frame.midX, y: state.frame.midY))
            
            for i in 0...childFeatures!.count - 1
            {
                path.addLine(to: convert(CGPoint(x: childFeatures![i].state.frame.midX, y: childFeatures![i].state.frame.midY), from: childFeatures![i]))
                path.move(to: CGPoint(x: state.frame.midX, y: state.frame.midY))
            }
            
            layerS.path = path.cgPath
        }
        
        super.draw(rect)
    }
    
    override func updateConstraints()
    {
        if !cons
        {
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
            label.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
            label.textColor = .black
            label.font = UIFont(name: "Copperplate", size: 19.5)!
            
            toggle.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
            toggle.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 1).isActive = true
            toggle.addTarget(self, action: #selector(sendPacket), for: .valueChanged)
            
            state.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 1).isActive = true
            state.centerYAnchor.constraint(equalTo: toggle.centerYAnchor, constant: 0).isActive = true
            state.widthAnchor.constraint(equalToConstant: 15).isActive = true
            state.heightAnchor.constraint(equalToConstant: 15).isActive = true
            state.layer.cornerRadius = 7.5
            state.layer.backgroundColor = UIColor.gray.cgColor
            
            if childFeatures != nil
            {
                
                for i in 0...childFeatures!.count - 1
                {
                    self.addSubview(childFeatures![i])
                    
                    if i == 0
                    {
                        childFeatures![i].translatesAutoresizingMaskIntoConstraints = false
                        childFeatures![i].leadingAnchor.constraint(equalTo: label.centerXAnchor).isActive = true
                        childFeatures![i].topAnchor.constraint(equalTo: toggle.bottomAnchor, constant: 5).isActive = true
                    }
                    else
                    {
                        childFeatures![i].translatesAutoresizingMaskIntoConstraints = false
                        childFeatures![i].leadingAnchor.constraint(equalTo: childFeatures![i-1].leadingAnchor).isActive = true
                        childFeatures![i].topAnchor.constraint(equalTo: childFeatures![i-1].bottomAnchor, constant: 5).isActive = true
                    }
                }
                
                self.bottomAnchor.constraint(equalTo: childFeatures![childFeatures!.count - 1].bottomAnchor, constant: 5).isActive = true
                self.trailingAnchor.constraint(equalTo: childFeatures![manualIndex != nil ? manualIndex! : childFeatures!.count - 1].trailingAnchor, constant: 5).isActive = true
            }
            else
            {
                self.bottomAnchor.constraint(equalTo: toggle.bottomAnchor, constant: 5).isActive = true
                self.trailingAnchor.constraint(equalTo: toggle.trailingAnchor, constant: 5).isActive = true
            }
            
        }
        
        super.updateConstraints()
    }
}

class FeatureC : UIView
{
    var cons = false
    
    var label : UILabel!
    var toggle : UISwitch!
    var state : UILabel!
    //    var state : UILabel!
    var args : String!
    
    public init (arg: String, featureName: String) {
        super.init(frame : CGRect.zero)
        //        self.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
        
        args = arg
        
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = featureName
        toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        state = UILabel()
        state.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label)
        self.addSubview(toggle)
        self.addSubview(state)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sendPacket()
    {
        switch ConnectionObj.client!.send(string: args + "," + (toggle.isOn ? "on" : "off")) {
        case .success:
            print("ez")
            break
        case .failure:
            print("terminated")
            break
        }
    }
    
    override func updateConstraints()
    {
        if !cons
        {
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
            label.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
            label.textColor = .black
            label.font = UIFont(name: "Copperplate-Light", size: 17.5)!
            
            toggle.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
            toggle.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 1).isActive = true
            toggle.addTarget(self, action: #selector(sendPacket), for: .valueChanged)
            
            state.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 1).isActive = true
            state.centerYAnchor.constraint(equalTo: toggle.centerYAnchor, constant: 0).isActive = true
            state.widthAnchor.constraint(equalToConstant: 15).isActive = true
            state.heightAnchor.constraint(equalToConstant: 15).isActive = true
            state.layer.cornerRadius = 7.5
            state.layer.backgroundColor = UIColor.gray.cgColor
            
            self.bottomAnchor.constraint(equalTo: toggle.bottomAnchor, constant: 5).isActive = true
            self.trailingAnchor.constraint(equalTo: toggle.trailingAnchor, constant: 5).isActive = true
        }
        
        super.updateConstraints()
    }
}
