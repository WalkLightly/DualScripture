//
//  ChapterEng.swift
//  DualScripture
//
//  Created by Michael Knight on 3/2/26.
//
import Foundation

struct ChapterEng: Codable   {
    let chapter: Int
    let reference: String
    let verses: [VerseEng]
}
