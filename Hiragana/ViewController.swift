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
    @IBOutlet weak var validationLabel: UILabel!
    
    private lazy var viewModel = ViewModel(
        inputTextObservable: inputTextField.rx.text.asObservable(),
        model: Model()
    )
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }


}

