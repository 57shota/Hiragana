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
import RxSwift

protocol rubyAnalysisAPI {
    func fetchRuby(text: String) -> Observable<String>
}

final class APIOperator: rubyAnalysisAPI {
    
    let api = "https://jlp.yahooapis.jp/FuriganaService/V1/furigana"
    let appID = "dj00aiZpPU5CZEhVbGJsQWtoaCZzPWNvbnN1bWVyc2VjcmV0Jng9Nzg-"
    
    func fetchRuby(text: String) -> Observable<String> {
        return Observable.create { [ weak self ] observer in
            let params = [
                "appid": self!.appID,
                "sentence": text,
            ]

            Alamofire.request(
                self!.api,
                method: .get,
                parameters: params,
                encoding: URLEncoding.default,
                headers: nil
                )
                .response { (response) in
                    print(response)
                    guard let data = response.data else {
                        print("cannot get XML")
                        observer.onError(ModelError.invalidSessionXML)
                        return
                    }
                    print(data)
                    let xml = SWXMLHash.parse(data)
                    var ruby = ""
                    let wordCount = xml["ResultSet"]["Result"]["WordList"]["Word"].all.count
                    
                    if wordCount == 0 {
                        observer.onError(ModelError.invalidXMLItem)
                    }else{
                        for i in 0...wordCount - 1 {
                            if let furigana = xml["ResultSet"]["Result"]["WordList"]["Word"][i]["Furigana"].element?.text {
                                ruby += furigana
                            }else if let notFurigana = xml["ResultSet"]["Result"]["WordList"]["Word"][i]["Surface"].element?.text {
                                ruby += notFurigana
                            }
                        }
                        observer.onNext(ruby)
                        observer.onCompleted()
                    }
            }

            return Disposables.create()
        }
    }
}
