//
//  DualLanguageVerse.swift
//  DualScripture
//
//  Created by Michael Knight on 3/5/26.
//

import Foundation

struct DualLanguageVerse: Codable  {
    var knownLangVerse: String
    var targetLangVerse: String
    var showTargetLang: Bool
    var verse: Int
}
