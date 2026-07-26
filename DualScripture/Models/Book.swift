//
//  Book.swift
//  DualScripture
//
//  Created by Michael Knight on 3/7/26.
//

import Foundation
var BOM_BOOKS: [Book] = [
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

var BOM_BOOKS_SPANISH: [Book] = [
    Book(name: "1 Nefi", chapterCount: 22, abbreviation: "1 Nefi"),
    Book(name: "2 Nefi", chapterCount: 33, abbreviation: "2 Nefi"),
    Book(name: "Jacob", chapterCount: 7, abbreviation: "Jacob"),
    Book(name: "Enós", chapterCount: 1, abbreviation: "Enós"),
    Book(name: "Jarom", chapterCount: 1, abbreviation: "Jarom"),
    Book(name: "Omni", chapterCount: 1, abbreviation: "Omni"),
    Book(name: "Palabras de Mormón", chapterCount: 1, abbreviation: "P de M"),
    Book(name: "Mosíah", chapterCount: 29, abbreviation: "Mosíah"),
    Book(name: "Alma", chapterCount: 63, abbreviation: "Alma"),
    Book(name: "Helamán", chapterCount: 16, abbreviation: "Helamán"),
    Book(name: "3 Nefi", chapterCount: 30, abbreviation: "3 Nefi"),
    Book(name: "4 Nefi", chapterCount: 1, abbreviation: "4 Nefi"),
    Book(name: "Mormón", chapterCount: 9, abbreviation: "Mormón"),
    Book(name: "Éter", chapterCount: 15, abbreviation: "Éter"),
    Book(name: "Moroni", chapterCount: 10, abbreviation: "Moroni"),
]

var BOM_BOOKS_TAGALOG: [Book] = [
    Book(name: "1 Nephi", chapterCount: 22, abbreviation: "1 Nephi"),
    Book(name: "2 Nephi", chapterCount: 33, abbreviation: "2 Nephi"),
    Book(name: "Jacob", chapterCount: 7, abbreviation: "Jacob"),
    Book(name: "Enos", chapterCount: 1, abbreviation: "Enos"),
    Book(name: "Jarom", chapterCount: 1, abbreviation: "Jarom"),
    Book(name: "Omni", chapterCount: 1, abbreviation: "Omni"),
    Book(name: "Mga Salita ni Mormon", chapterCount: 1, abbreviation: "S ni M"),
    Book(name: "Mosiah", chapterCount: 29, abbreviation: "Mosiah"),
    Book(name: "Alma", chapterCount: 63, abbreviation: "Alma"),
    Book(name: "Helaman", chapterCount: 16, abbreviation: "Helaman"),
    Book(name: "3 Nephi", chapterCount: 30, abbreviation: "3 Nephi"),
    Book(name: "4 Nephi", chapterCount: 1, abbreviation: "4 Nephi"),
    Book(name: "Mormon", chapterCount: 9, abbreviation: "Mormon"),
    Book(name: "Eter", chapterCount: 15, abbreviation: "Eter"),
    Book(name: "Moroni", chapterCount: 10, abbreviation: "Moroni"),
]

var BOM_BOOKS_CEBUANO: [Book] = [
    Book(name: "1 Nephi", chapterCount: 22, abbreviation: "1 Nephi"),
    Book(name: "2 Nephi", chapterCount: 33, abbreviation: "2 Nephi"),
    Book(name: "Jacob", chapterCount: 7, abbreviation: "Jacob"),
    Book(name: "Enos", chapterCount: 1, abbreviation: "Enos"),
    Book(name: "Jarom", chapterCount: 1, abbreviation: "Jarom"),
    Book(name: "Omni", chapterCount: 1, abbreviation: "Omni"),
    Book(name: "Mga Pulong ni Mormon", chapterCount: 1, abbreviation: "P ni M"),
    Book(name: "Mosiah", chapterCount: 29, abbreviation: "Mosiah"),
    Book(name: "Alma", chapterCount: 63, abbreviation: "Alma"),
    Book(name: "Helaman", chapterCount: 16, abbreviation: "Helaman"),
    Book(name: "3 Nephi", chapterCount: 30, abbreviation: "3 Nephi"),
    Book(name: "4 Nephi", chapterCount: 1, abbreviation: "4 Nephi"),
    Book(name: "Mormon", chapterCount: 9, abbreviation: "Mormon"),
    Book(name: "Ether", chapterCount: 15, abbreviation: "Ether"),
    Book(name: "Moroni", chapterCount: 10, abbreviation: "Moroni"),
]

struct Book: Hashable {
    let name: String
    let chapterCount: Int
    let abbreviation: String
}

