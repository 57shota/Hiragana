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
    
    private let disposeBag = DisposeBag()
    let validationText: Observable<String>
    let rubyObservable: Observable<String>
    var translateText: String
    
    init(inputTextObservable: Observable<String?>, changeButtonClicked: Observable<Void>, model: ModelProtocol, api: rubyAnalysisAPI) {
        
        let event = inputTextObservable
            .flatMap { input -> Observable<Event<Void>> in
                if let text = input {
                    self.translateText = text
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
            .flatMap { () -> Observable<Event<String>> in
                return api
                    .fetchRuby(text: self.translateText)
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
        
        
        
        
        
        
//        tapEvent
//            .flatMap { event -> Observable<String> in
//                event.element.map(Observable.just) ?? .empty()
//            }
//            .subscribe(onNext: { error in
//                // TODO: Error Handling
//            })
//            .disposed(by: disposeBag)
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
        }
        
    }
}
