//
//  BookEng.swift
//  DualScripture
//
//  Created by Michael Knight on 3/2/26.
//
import Foundation

struct BookEng: Codable  {
    let book: String
    let chapters: [ChapterEng]
    let full_title: String
    let lds_slug: String
}
