//
//  String+UTF8Decoding.swift
//  BabelCamera
//
//  Created by Andy Cho on 2017-07-21.
//  Copyright © 2017 AcroMace. All rights reserved.
//

import UIKit

// Since the Google Translate API returns a UTF-8 encoded string, we need a way to decode it

extension String {

    func decodeUTF8() -> String? {
        guard let data = data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributed = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        return attributed.string
    }

}
