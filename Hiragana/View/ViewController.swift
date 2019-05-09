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
import LTMorphingLabel

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: LTMorphingLabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var cloudSImageView: UIImageView!
    @IBOutlet weak var cloudMImageView: UIImageView!
    @IBOutlet weak var cloudLImageView: UIImageView!
    @IBOutlet weak var circleImageView: UIImageView!
    
    private lazy var viewModel = ViewModel(
        inputTextObservable: inputTextField.rx.text.asObservable(),
        changeButtonClicked: changeButton.rx.tap.asObservable(),
        model: Model()
    )
    
    lazy var circleAnimator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 10, delay: 0.0, options: [.curveLinear], animations: {
        UIView.setAnimationRepeatCount(100)
        self.circleImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/180*180)
    })
    
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
        
        viewModel.validationText
            .subscribe(onNext: { (str) in
                switch str {
                case ModelError.invalidLendth.errorLabel, ModelError.invalidBlank.errorLabel:
                    self.isEnabledCircleImageAnimation(animate: false)
                default:
                    self.isEnabledCircleImageAnimation(animate: true)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.rubyObservable
            .bind(to: outputLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func initialSet() {
        outputLabel.text = ""
        inputTextField.text = ""
        outputLabel.morphingEffect = .sparkle
        
        UIView.animate(withDuration: 9, delay: 0.0, options: [.curveEaseInOut, .autoreverse, .repeat], animations: {
            self.cloudSImageView.center.x -= 200
        })
        UIView.animate(withDuration: 18, delay: 0.0, options: [.curveEaseInOut, .autoreverse, .repeat], animations: {
            self.cloudMImageView.center.x += 200
        })
        UIView.animate(withDuration: 25, delay: 0.0, options: [.curveEaseInOut, .autoreverse, .repeat], animations: {
            self.cloudLImageView.center.x += 200
        })
        
        isEnabledCircleImageAnimation(animate: false)
    }
    
    func isEnabledCircleImageAnimation(animate result: Bool) {
        switch result {
        case true:
            self.changeButton.isEnabled = result
            self.circleImageView.alpha = 0.4
            self.circleAnimator.startAnimation()
        case false:
            self.changeButton.isEnabled = result
            self.circleImageView.alpha = 0.1
            self.circleAnimator.pauseAnimation()
        }   
    }
}
