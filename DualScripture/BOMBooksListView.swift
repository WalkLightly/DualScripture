//
//  BOMChapterListView.swift
//  DualScripture
//
//  Created by Michael Knight on 3/7/26.
//

import SwiftUI

struct BOMBooksListView: View {
    @Binding var primaryLang: String
    @Binding var secondaryLang: String
    @State var chosenBook: String = "1 Nephi"
    
    func getBooksList() -> [Book] {
        if primaryLang == "English" {
            return BOM_BOOKS
        } else if primaryLang == "Spanish" {
            return BOM_BOOKS_SPANISH
        } else if primaryLang == "Cebuano" {
            return BOM_BOOKS_CEBUANO
        } else {
            return BOM_BOOKS_TAGALOG
        }
                
    }
    var body: some View {
        VStack {
            List {
                ForEach (getBooksList(), id: \.self.name) { book in
                    
                    if book.chapterCount > 1 {
                        NavigationLink(destination: BOMChaptersListView(primaryLang: $primaryLang, secondaryLang: $secondaryLang, chaptersCount: book.chapterCount, bomBook: book.name)) {
                            HStack {
                                VStack() {
                                    Spacer()
                                    Text(book.name)
                                        .font(.custom("Inder-Regular", size: 20))
                                        .foregroundStyle(.white)
                                        .padding(.top, -16)
                                }
                                Spacer()
                                if book.chapterCount > 1 {
                                    Button {
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
                        NavigationLink(destination: BOMChaptersListView(primaryLang: $primaryLang, secondaryLang: $secondaryLang, chaptersCount: book.chapterCount, bomBook: book.name)) {
                            HStack {
                                VStack() {
                                    Spacer()
                                    Text(book.name)
                                        .font(.custom("Inder-Regular", size: 20))
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
    BOMBooksListView(primaryLang: .constant("Tagalog"), secondaryLang: .constant("English"))
}
