//
//  BaseVC.swift
//  KiskoLabsTask
//
//  Created by Hassan Shahid on 11/06/2020.
//  Copyright © 2020 Hassan Shahid. All rights reserved.
//

import UIKit
import RappleProgressHUD

class BaseVC: UIViewController {

    //MARK:- Load
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Functions
    func startLoader() {
        RappleActivityIndicatorView.startAnimating(attributes: RappleModernAttributes)
    }
    
    func stopLoader() {
        RappleActivityIndicatorView.stopAnimation()
    }
    
    func showAlert(message: String)
    {
        let alert = UIAlertController(title: "Kisko Labs", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


