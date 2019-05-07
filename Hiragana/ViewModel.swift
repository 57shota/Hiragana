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
    
    let validationText: Observable<Bool>
    
    init(inputTextObservable: Observable<String?>, model: ModelProtocol) {
        
        let event = inputTextObservable
            .flatMap { input -> Observable<Event<Void>> in
                return model
                    .validate(text: input)
                    .materialize()
            }
            .share()
        
        self.validationText = event
            .flatMap { event -> Observable<Bool> in
                switch event {
                case .next:
                    let notIsHidden = false
                    return .just(notIsHidden)
                case let .error(error as ModelError):
                    return .just(error.errorLabel)
                case .error, .completed:
                    return .empty()
                }
                
        }
     
        
        
    }
}

extension ModelError {
    
    var errorLabel: Bool {
        switch self {
        case .invalidBlank:
            <#code#>
        case .invalidLendth:
            <#code#>
        }
    }
    
}
