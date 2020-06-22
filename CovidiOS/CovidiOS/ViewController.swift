//
//  ViewController.swift
//  CovidiOS
//
//  Created by Nguyen Duc Manh on 6/21/20.
//  Copyright © 2020 Nguyen Duc Manh. All rights reserved.
//

import UIKit
import Flutter

class ViewController: UIViewController {
    @IBOutlet weak var flutterView: UIView!
    
    
    var flutterViewController: FlutterViewController!
    var flutterEngineHalfScreen: FlutterEngine!
    var flutterEnginer: FlutterEngine!
    override func viewDidLoad() {
        super.viewDidLoad()
        addFlutterView()
    }
    
    
    func addFlutterView(){
        flutterEngineHalfScreen = (UIApplication.shared.delegate as! AppDelegate).flutterEngineHalfScreen
        flutterViewController = FlutterViewController(engine: flutterEngineHalfScreen, nibName: nil, bundle: nil)
        addChild(flutterViewController)
        flutterViewController.view.translatesAutoresizingMaskIntoConstraints = false
        flutterView.addSubview(flutterViewController.view)
        let constraints = [
            flutterViewController.view.topAnchor.constraint(equalTo: flutterView.topAnchor),
            flutterViewController.view.leadingAnchor.constraint(equalTo: flutterView.leadingAnchor),
            flutterViewController.view.bottomAnchor.constraint(equalTo: flutterView.bottomAnchor),
            flutterViewController.view.trailingAnchor.constraint(equalTo: flutterView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        flutterViewController.didMove(toParent: self)
        flutterViewController.view.layoutIfNeeded()
        
    }
    
    
    @IBAction func openFlutterController(_ sender: UIButton) {
        let flutterVC = FlutterViewController(engine: flutterEngineHalfScreen, nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(flutterVC, animated: true)
    }
    
    @IBAction func openFlutterVC2(_ sender: UIButton) {
        flutterEnginer = (UIApplication.shared.delegate as! AppDelegate).flutterEngineFullScreen
        let flutterVC = MyFlutterVC.init(engine: flutterEnginer, nibName: nil, bundle: nil)
        flutterVC.modalPresentationStyle = .fullScreen
        self.present(flutterVC, animated: true, completion: nil)
    }
    
    @IBAction func OpenVNCovid(_ sender: UIButton) {
        flutterEnginer = (UIApplication.shared.delegate as! AppDelegate).flutterEngineFullScreen
        let flutterVC = MyFlutterVC.init(engine: flutterEnginer, nibName: nil, bundle: nil)
        flutterVC.screen = "DetailPage"
        flutterVC.country = "Vietnam"
        flutterVC.modalPresentationStyle = .fullScreen
        self.present(flutterVC, animated: true, completion: nil)
    }
}

