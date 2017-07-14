//
//  TranslationService.swift
//  BabelCamera
//
//  Created by Andy Cho on 2017-07-13.
//  Copyright © 2017 AcroMace. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// Google translation service
class TranslationService {

    // This should be regenerated when the source code is made public
    private let googleApiKey = "AIzaSyCmOrzE7SCZ2kAbJluNffiHe3tzDWwVW5w"
    private let translateEndpoint = "https://translation.googleapis.com/language/translate/v2"

    func translate(text: String, to language: Language, callback: @escaping (String) -> Void) {
        let parameters: Parameters = [
            "q": text,
            "source": Language.english.googleString(),
            "target": language.googleString()
        ]
        Alamofire.request(
            "\(translateEndpoint)?key=\(googleApiKey)",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    guard let translation = json["data"]["translations"][0]["translatedText"].string else {
                        print("Translation failed or invalid JSON: \(json)")
                        return
                    }
                    print("Translation successful: \(translation)")
                    callback(translation)
                case .failure(let error):
                    print(error)
                }
            }
    }

}
