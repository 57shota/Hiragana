//
//  Model.swift
//  Hiragana
//
//  Created by Shota Ito on 2019/05/06.
//  Copyright © 2019 Shota Ito. All rights reserved.
//

import RxSwift

protocol ModelProtocol {
    func validate(text: String) -> Observable<Void>
}

final class Model: ModelProtocol {
    
    func validate(text: String) -> Observable<Void> {
        <#code#>
    }
    
    
}
