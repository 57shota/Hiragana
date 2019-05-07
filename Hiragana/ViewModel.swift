//
//  ViewModel.swift
//  Hiragana
//
//  Created by Shota Ito on 2019/05/06.
//  Copyright © 2019 Shota Ito. All rights reserved.
//

import UIKit
import RxSwift

final class ViewModel {
    
    let validationText: Observable<String>
    
    init(inputTextObservable: Observable<String?>, model: ModelProtocol) {
        
        let event = inputTextObservable
            .flatMap { input -> Observable<Event<Void>> in
                return model
                    .validate(text: input)
                    .materialize()
            }
            .share()
        
        self.validationText = event
            .flatMap { event -> Observable<String> in
                switch event {
                case .next:
                    return .just("")
                case let .error(error as ModelError):
                    return .just(error.errorLabel)
                case .error, .completed:
                    return .empty()
                }
        }
        .startWith(ModelError.invalidBlank.errorLabel)
     
    }
}

extension ModelError {
    
    var errorLabel: String {
        switch self {
        case .invalidBlank:
            return "書いてみよう！"
        case .invalidLendth:
            return "文章が長くて魔法が使えない！"
        }
    }
    
}
