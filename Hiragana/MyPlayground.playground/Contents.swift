import Alamofire
import SWXMLHash
import RxSwift
import SwiftyXMLParser

var str = "Hello, playground"

let api = "https://jlp.yahooapis.jp/FuriganaService/V1/furigana"
let appID = "dj00aiZpPU5CZEhVbGJsQWtoaCZzPWNvbnN1bWVyc2VjcmV0Jng9Nzg-"
var ruby = ""

func fetchRuby(text: String) -> Observable<String> {
    return Observable.create { observer in
        
        
        return Disposables.create()
    }
}

let params = [
    "appid": appID,
    "sentence": "天気",
]

Alamofire.request(
    api,
    method: .get,
    parameters: params,
    encoding: URLEncoding.default,
    headers: nil
    )
    .response { (response) in
//        print(response)
        print(response.data!)
        var xml = SWXMLHash.parse(response.data!)
        
        
//        let data = response.result.value!
        
//        print(xml["ResultSet"]["Result"]["WordList"]["Word"]["Furigana"].element?.text)
        
        
        // request 2
//            .responseString { (response) in
//                print(response)
//                guard let data = response.result.value else {
//                    print("cannot get XML")
//                    return
//                }
//                print(data)
//
//                let xml = try! XML.parse(data)
//
//                //                    print(xml["ResultSet"]["Result"]["WordList"]["Word"]["Furigana"].element?.text)
//
//                let wordCount = xml.ResultSet.Result.WordList.Word[1]
//                //                    for i
        
        
}

