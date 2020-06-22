//
//  MyFlutterVC.swift
//  CovidiOS
//
//  Created by Nguyen Duc Manh on 6/22/20.
//  Copyright © 2020 Nguyen Duc Manh. All rights reserved.
//

import UIKit
import Flutter

class MyFlutterVC: FlutterViewController {
    
    var screen: String!
    var country: String!
    
    var flutterChannel: FlutterMethodChannel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flutterChannel = FlutterMethodChannel.init(name: "com.manhnd.covid", binaryMessenger: self.binaryMessenger)
        
        flutterChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "exitFlutter":
                self?.exitFlutter()
            case "getParamCountry":
                result(self?.country)
            case "GotoSecondPageNative":
                self?.gotoSecondVC(call: call)
            default:
                result(FlutterMethodNotImplemented)
                return
            }
        })
        flutterChannel.invokeMethod("gotoPage", arguments: screen)
    }
    
    func exitFlutter(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func gotoSecondVC(call: FlutterMethodCall){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        guard let args = call.arguments else {
            return
        }
        if let myArgs = args as? [String: Any],
            let confirmed = myArgs["confirmed"] as? Int{
            newViewController.confirmed = confirmed
        } else {
            
        }
        self.present(newViewController, animated: true, completion: nil)
    }
    
}
