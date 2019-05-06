//
//  ViewController.swift
//  Hiragana
//
//  Created by Shota Ito on 2019/05/05.
//  Copyright © 2019 Shota Ito. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    
    private lazy var viewModel = ViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

