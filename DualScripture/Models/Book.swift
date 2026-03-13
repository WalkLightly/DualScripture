//
//  Book.swift
//  DualScripture
//
//  Created by Michael Knight on 3/7/26.
//

import Foundation
let BOM_BOOKS: [Book] = [
    Book(name: "1 Nephi", chapterCount: 22, abbreviation: "1 Nephi"),
    Book(name: "2 Nephi", chapterCount: 33, abbreviation: "2 Nephi"),
    Book(name: "Jacob", chapterCount: 7, abbreviation: "Jacob"),
    Book(name: "Enos", chapterCount: 1, abbreviation: "Enos"),
    Book(name: "Jarom", chapterCount: 1, abbreviation: "Jarom"),
    Book(name: "Omni", chapterCount: 1, abbreviation: "Omni"),
    Book(name: "Words of Mormon", chapterCount: 1, abbreviation: "W of M"),
    Book(name: "Mosiah", chapterCount: 29, abbreviation: "Mosiah"),
    Book(name: "Alma", chapterCount: 63, abbreviation: "Alma"),
    Book(name: "Helaman", chapterCount: 16, abbreviation: "Helaman"),
    Book(name: "3 Nephi", chapterCount: 30, abbreviation: "3 Nephi"),
    Book(name: "4 Nephi", chapterCount: 1, abbreviation: "4 Nephi"),
    Book(name: "Mormon", chapterCount: 9, abbreviation: "Mormon"),
    Book(name: "Ether", chapterCount: 15, abbreviation: "Ether"),
    Book(name: "Moroni", chapterCount: 10, abbreviation: "Moroni"),
]

struct Book  {
    let name: String
    let chapterCount: Int
    let abbreviation: String
}

