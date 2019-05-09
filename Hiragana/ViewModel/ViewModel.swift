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
    
    private let api: rubyAnalysisAPI
    let validationText: Observable<String>
    let rubyObservable: Observable<String>
    
    init(inputTextObservable: Observable<String?>, changeButtonClicked: Observable<Void>, model: ModelProtocol, api: rubyAnalysisAPI = APIOperator()) {
        
        self.api = api
        var test = ""
        
        let event = inputTextObservable
            .flatMap { input -> Observable<Event<Void>> in
                if let text = input {
                    test = text
                }
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
        
        let tapEvent = changeButtonClicked
            .flatMap { (result) -> Observable<Event<String>> in
                return api
                    .fetchRuby(text: test)
                    .materialize()
        }
        .share()

        self.rubyObservable = tapEvent
            .flatMap { event -> Observable<String> in
                switch event {
                case .next:
                    return .just(event.element!)
                case let .error(error as ModelError):
                    return .just(error.errorLabel)
                case .error, .completed:
                    return .empty()
                }
            }
    }
}

extension ModelError {
    
    var errorLabel: String {
        switch self {
        case .invalidBlank:
            return "書いてみよう！"
        case .invalidLendth:
            return "文章が長くて魔法が使えない！"
        case .invalidSessionXML:
            return "データ取得に失敗しました"
        case .invalidXMLItem:
            return ""
        }
        
    }
}
