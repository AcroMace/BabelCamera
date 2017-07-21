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
    private let googleApiKey = Bundle.main.infoDictionary?["GoogleTranslateAPIKey"] as? String
    private let translateEndpoint = "https://translation.googleapis.com/language/translate/v2"

    func translate(text: String, to language: Language, callback: @escaping (String) -> Void) {
        guard let apiKey = googleApiKey, !apiKey.isEmpty else {
            print("Remember to copy Keys.example.xcconfig to Keys.xcconfig and replace the key!")
            callback("Google Translate API not set")
            return
        }

        let parameters: Parameters = [
            "q": text,
            "source": Language.english.googleString(),
            "target": language.googleString()
        ]
        Alamofire.request(
            "\(translateEndpoint)?key=\(apiKey)",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil
        )
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                guard let statusCode = response.response?.statusCode else {
                    print("Status code for response not found")
                    print(response)
                    callback("Translation failed: check connection")
                    return
                }
                guard case 200..<300 = statusCode else {
                    print("Google translation API request failed")
                    print(response)
                    callback("Translation failed (Status \(statusCode))")
                    return
                }
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    guard let translation = json["data"]["translations"][0]["translatedText"].string,
                        let decodedTranslation = translation.decodeUTF8() else {
                        print("Translation failed or invalid JSON: \(json)")
                        return
                    }
                    print("Translation successful: \(decodedTranslation)")
                    callback(decodedTranslation)
                case .failure(let error):
                    print(error)
                    callback(error.localizedDescription)
                }
            }
    }

}
