//
//  Language.swift
//  BabelCamera
//
//  Created by Andy Cho on 2017-07-14.
//  Copyright © 2017 AcroMace. All rights reserved.
//

import Foundation

// swiftlint:disable cyclomatic_complexity function_body_length type_body_length

enum Language {
    // These are the languages available for both speech and translation
    case arabic
    case chineseSimplified
    case chineseTraditional
    case czech
    case danish
    case dutch
    case english
    case finnish
    case french
    case german
    case greek
    case hebrew
    case hindi
    case hungarian
    case indonesian
    case italian
    case japanese
    case korean
    case norwegian
    case polish
    case portuguese
    case romanian
    case russian
    case slovak
    case spanish
    case swedish
    case thai
    case turkish

    static func all() -> [Language] {
        return [.arabic, .chineseSimplified, .chineseTraditional, .czech, .danish,
                .dutch, .english, .finnish, .french, .german, .greek, .hebrew,
                .hindi, .hungarian, .indonesian, .italian, .japanese, .korean,
                .norwegian, .polish, .portuguese, .romanian, .russian, .slovak,
                .spanish, .swedish, .thai, .turkish]
    }

    // Description of the language for display
    func description() -> String {
        switch self {
        case .arabic:
            return "Arabic"
        case .chineseSimplified:
            return "Chinese (Simplified)"
        case .chineseTraditional:
            return "Chinese (Traditional)"
        case .czech:
            return "Czech"
        case .danish:
            return "Danish"
        case .dutch:
            return "Dutch"
        case .english:
            return "English"
        case .finnish:
            return "Finnish"
        case .french:
            return "French"
        case .german:
            return "German"
        case .greek:
            return "Greek"
        case .hebrew:
            return "Hewbrew"
        case .hindi:
            return "Hindi"
        case .hungarian:
            return "Hungarian"
        case .indonesian:
            return "Indonesian"
        case .italian:
            return "Italian"
        case .japanese:
            return "Japanese"
        case .korean:
            return "Korean"
        case .norwegian:
            return "Norwegian"
        case .polish:
            return "Polish"
        case .portuguese:
            return "Portuguese"
        case .romanian:
            return "Romanian"
        case .russian:
            return "Russian"
        case .slovak:
            return "Slovak"
        case .spanish:
            return "Spanish"
        case .swedish:
            return "Swedish"
        case .thai:
            return "Thai"
        case .turkish:
            return "Turkish"
        }
    }

    // BCP-47 codes
    // http://nshipster.com/avspeechsynthesizer/
    func speechString() -> String {
        switch self {
        case .arabic:
            return "ar-SA"
        case .chineseSimplified:
            // zh-CN, zh-HK
            return "zh-CN"
        case .chineseTraditional:
            return "zh-TW"
        case .czech:
            return "cs-CZ"
        case .danish:
            return "da-DK"
        case .dutch:
            // nl-BE, nl-NL
            return "nl-BE"
        case .english:
            // en-AU, en-GB, en-IE, en-US, en-ZA
            return "en-GB"
        case .finnish:
            return "fi-FI"
        case .french:
            // fr-CA, fr-FR
            return "fr-CA"
        case .german:
            return "de-DE"
        case .greek:
            return "el-GR"
        case .hebrew:
            return "he-IL"
        case .hindi:
            return "hi-IN"
        case .hungarian:
            return "hu-HU"
        case .indonesian:
            return "id-ID"
        case .italian:
            return "it-IT"
        case .japanese:
            return "ja-JP"
        case .korean:
            return "ko-KR"
        case .norwegian:
            return "no-NO"
        case .polish:
            return "pl-PL"
        case .portuguese:
            // pt-BR, pt-PT
            return "pt-BR"
        case .romanian:
            return "ro-RO"
        case .russian:
            return "ru-RU"
        case .slovak:
            return "sk-SK"
        case .spanish:
            // es-ES, es-MX
            return "es-ES"
        case .swedish:
            return "sv-SE"
        case .thai:
            return "th-TH"
        case .turkish:
            return "tr-TR"
        }
    }

    // ISO-638-1 codes
    // https://cloud.google.com/translate/docs/languages
    func googleString() -> String {
        switch self {
        case .arabic:
            return "ar"
        case .chineseSimplified:
            return "zh-CN"
        case .chineseTraditional:
            return "zh-TW"
        case .czech:
            return "cs"
        case .danish:
            return "da"
        case .dutch:
            return "nl"
        case .english:
            return "en"
        case .finnish:
            return "fi"
        case .french:
            return "fr"
        case .german:
            return "de"
        case .greek:
            return "el"
        case .hebrew:
            return "iw"
        case .hindi:
            return "hi"
        case .hungarian:
            return "hu"
        case .indonesian:
            return "id"
        case .italian:
            return "it"
        case .japanese:
            return "ja"
        case .korean:
            return "ko"
        case .norwegian:
            return "no"
        case .polish:
            return "pl"
        case .portuguese:
            return "pt"
        case .romanian:
            return "ro"
        case .russian:
            return "ru"
        case .slovak:
            return "sk"
        case .spanish:
            return "es"
        case .swedish:
            return "sv"
        case .thai:
            return "th"
        case .turkish:
            return "tr"
        }
    }
}
