//
//  DualLanguageBook.swift
//  DualScripture
//
//  Created by Michael Knight on 3/5/26.
//

import Foundation

struct DualLanguageBook: Codable  {
    let book: String
    let chapters: [ChapterEng]
    let full_title: String
    let lds_slug: String
}
