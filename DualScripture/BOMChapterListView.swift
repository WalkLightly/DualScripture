//
//  BOMChapterListView.swift
//  DualScripture
//
//  Created by Michael Knight on 3/7/26.
//

import SwiftUI

let BOM_BOOKS: [Book] = [
    Book(name: "1 Nephi", chapterCount: 22),
    Book(name: "2 Nephi", chapterCount: 33),
    Book(name: "Jacob", chapterCount: 7),
    Book(name: "Enos", chapterCount: 1),
    Book(name: "Jarom", chapterCount: 1),
    Book(name: "Omni", chapterCount: 1),
    Book(name: "Words of Mormon", chapterCount: 1),
    Book(name: "Mosiah", chapterCount: 29),
    Book(name: "Alma", chapterCount: 63),
    Book(name: "Helaman", chapterCount: 16),
    Book(name: "3 Nephi", chapterCount: 30),
    Book(name: "4 Nephi", chapterCount: 1),
    Book(name: "Mormon", chapterCount: 9),
    Book(name: "Ether", chapterCount: 15),
    Book(name: "Moroni", chapterCount: 10),
]


struct BOMChapterListView: View {
    var body: some View {
        VStack {
            List {
                ForEach (BOM_BOOKS, id: \.self.name) { book in
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
            .scrollContentBackground(.hidden)
            .background(.black)
        }
    }
}

#Preview {
    BOMChapterListView()
}
