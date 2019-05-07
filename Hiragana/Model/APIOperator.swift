//
//  APIOperator.swift
//  Hiragana
//
//  Created by Shota Ito on 2019/05/07.
//  Copyright © 2019 Shota Ito. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

protocol rubyAnalysisAPI {
    func fetchRuby(text: String)
}

final class APIOperator: rubyAnalysisAPI {
    
    let api = "https://jlp.yahooapis.jp/FuriganaService/V1/furigana"
    let appID = "dj00aiZpPU5CZEhVbGJsQWtoaCZzPWNvbnN1bWVyc2VjcmV0Jng9Nzg-"
    
    func fetchRuby(text: String) {
        
        let params = [
            "appid": appID,
            "sentence": text,
            "grade": "1"
        ]
        
        Alamofire.request(
            api,
            method: .get,
            parameters: params,
            encoding: URLEncoding.default,
            headers: nil
        )
            .response { (response) in
                guard let object = response.data else {
                    print("Getting API data is failed")
                    return
                }
                print(object)
                var xml = SWXMLHash.parse(object)
        }
        
    }
    
    
    
    
}
