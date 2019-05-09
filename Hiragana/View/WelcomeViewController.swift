//
//  WelcomeViewController.swift
//  Hiragana
//
//  Created by Shota Ito on 2019/05/09.
//  Copyright © 2019 Shota Ito. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 15
        modalView.layer.cornerRadius = 20
    }
    
    @IBAction func actionButton(_ sender: Any) {
        let previous = presentingViewController as! ViewController
        previous.modalTransitionStyle = .crossDissolve
        self.dismiss(animated: true, completion: nil)
    }
}
