//
//  ScriptureVerse.swift
//  DualScripture
//
//  Created by Michael Knight on 3/1/26.
//
import Foundation

struct ScriptureVerse: Hashable {
    var targetLangVerse: String
    var showTargetLang: Bool = true
    var knownLangVerse: String
    var verseNumber: String
}
