//
//  Model.swift
//  Hiragana
//
//  Created by Shota Ito on 2019/05/06.
//  Copyright © 2019 Shota Ito. All rights reserved.
//

import RxSwift

protocol ModelProtocol {
    func validate(text: String?) -> Observable<Void>
}


final class Model: ModelProtocol {
    
    func validate(text: String?) -> Observable<Void> {
        
        switch text {
        case .none:
            return Observable.error(ModelError.invalidBlank)
        case let text?:
            
            switch text.isEmpty {
            case true:
                return Observable.error(ModelError.invalidBlank)
            case false:
                let textLimit = 30
                if text.count > textLimit {
                    return Observable.error(ModelError.invalidLendth)
                }else{
                    return Observable.just(())
                }
            }
        }
    }
}
