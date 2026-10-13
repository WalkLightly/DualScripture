//
//  DualLanguageConferenceTalk.swift
//  DualScripture
//
//  Created by Michael Knight on 10/11/26.
//

import Foundation

struct DualLanguageConferenceTalkParagraphs: Codable  {
    var knownLangVerse: [String]
    var targetLangVerse: [String]
    var showTargetLang: Bool
}
