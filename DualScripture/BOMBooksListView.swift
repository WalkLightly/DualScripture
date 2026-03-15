//
//  BOMChapterListView.swift
//  DualScripture
//
//  Created by Michael Knight on 3/7/26.
//

import SwiftUI

struct BOMBooksListView: View {
    var primaryLang: String
    var secondaryLang: String
    @State var chosenBook: String = "1 Nephi"
    
    var body: some View {
        VStack {
            List {
                ForEach (BOM_BOOKS, id: \.self.name) { book in
                    
                    if book.chapterCount > 1 {
                        NavigationLink(destination: BOMChaptersListView(chaptersCount: book.chapterCount, bomBook: book.name)) {
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
                        NavigationLink(destination: VersesView()) {
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
    BOMBooksListView(primaryLang: "Tagalog", secondaryLang: "English")
}
