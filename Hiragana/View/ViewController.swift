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
        changeButtonClicked: changeButton.rx.tap.asObservable(),
        model: Model()
    )
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSet()
        
        inputTextField.rx.text.orEmpty
            .map { $0.description}
            .bind(to: outputLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.validationText
            .bind(to: validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.

    }
    
    func initialSet() {
        outputLabel.text = ""
        inputTextField.text = ""
    }
}
