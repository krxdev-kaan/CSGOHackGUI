//
//  ConnectionViewController.swift
//  CSGOHackGUI
//
//  Created by Kaan Uyumaz on 15.08.2019.
//  Copyright © 2019 Kaan Uyumaz. All rights reserved.
//

import Foundation
import UIKit
import SwiftSocket

class ConnectionViewController : UIViewController
{
    var safeArea : UILayoutGuide!
    
    let button = UIButton(type: .system)
    let ipBar = UITextField()
    let saveButton = UIButton(type: .system)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .white
        
        let userDefs = UserDefaults.standard
        let save : String? = userDefs.string(forKey: "savedIP")
        
        if save != nil
        {
            ipBar.text = save
        }
        
        setup()
    }
    
    func setup()
    {
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        button.setTitle("Connect", for: .normal)
        button.titleLabel?.font = UIFont(descriptor: .init(), size: 18)
        button.addTarget(self, action: #selector(connect), for: .touchDown)
        
        view.addSubview(ipBar)
        
        ipBar.translatesAutoresizingMaskIntoConstraints = false
        ipBar.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10).isActive = true
        ipBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ipBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        ipBar.placeholder = "IP Address"
        ipBar.delegate = self
        ipBar.borderStyle = .roundedRect
        ipBar.layer.borderWidth = 1
        
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: ipBar.bottomAnchor, constant: 10).isActive = true
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont(descriptor: .init(), size: 18)
        saveButton.addTarget(self, action: #selector(saveData), for: .touchDown)
    }
    
    @objc func saveData()
    {
        let userDefs = UserDefaults.standard
        
        userDefs.set(ipBar.text, forKey: "savedIP")
    }
    
    @objc func connect()
    {
        ConnectionObj.client = TCPClient(address: ipBar.text ?? "127.0.0.1", port: 8080)
        switch ConnectionObj.client!.connect(timeout: 10) {
        case .success:
            button.setTitle("CONNECTED", for: .normal)
            switch ConnectionObj.client!.send(string: "Merhabalar AQ" ) {
            case .success:
                //                        guard let data = client.read(1024*10) else { return }
                //
                //                        if let response = String(bytes: data, encoding: .utf8) {
                //                            print(response)
                //                        }
                print("message sent to server")
                tabBarController?.tabBar.items![1].isEnabled = true
                tabBarController?.tabBar.items![2].isEnabled = true
                (self.navigationController as! MainNavigationController).label.layer.backgroundColor = UIColor.green.cgColor
                break
                
            case .failure(let error):
                button.setTitle("DISCONNECTED", for: .normal)
                (self.navigationController as! MainNavigationController).label.layer.backgroundColor = UIColor.red.cgColor
                break
            }
            break
            
        case .failure(let error):
            print(error)
            break
        }
    }
    
}

extension ConnectionViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
