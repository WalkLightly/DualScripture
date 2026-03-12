//
//  BOMChapterListView.swift
//  DualScripture
//
//  Created by Michael Knight on 3/7/26.
//

import SwiftUI

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


struct BOMBooksListView: View {
    var primaryLang: String
    var secondaryLang: String
    
    var body: some View {
        VStack {
            List {
                ForEach (BOM_BOOKS, id: \.self.name) { book in
                    
                    if book.chapterCount > 1 {
                        NavigationLink(destination: BOMChaptersListView(chaptersCount: book.chapterCount)) {
                            HStack {
                                VStack() {
                                    Spacer()
                                    Text(book.name)
                                        .font(.custom("Poppins-Regular", size: 20))
                                        .foregroundStyle(.white)
                                        .padding(.top, -16)
                                }
                                Spacer()
                                if book.chapterCount > 1 {
                                    Button {
                                        // take to the chapter
                                    } label: {
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                            
                        }
                        .listRowBackground(Color.black)
                        .navigationLinkIndicatorVisibility(.hidden)
                    } else {
                        NavigationLink(destination: VersesView()) {
                            HStack {
                                VStack() {
                                    Spacer()
                                    Text(book.name)
                                        .font(.custom("Poppins-Regular", size: 20))
                                        .foregroundStyle(.white)
                                        .padding(.top, -16)
                                }
                                Spacer()
                                if book.chapterCount > 1 {
                                    Button {
                                        // take to the chapter
                                    } label: {
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                            
                        }
                        .listRowBackground(Color.black)
                        .navigationLinkIndicatorVisibility(.hidden)
                    }

                }
            }
            .scrollContentBackground(.hidden)
            .background(.black)
        }
    }
}

#Preview {
    BOMBooksListView(primaryLang: "Tagalog", secondaryLang: "English")
}
