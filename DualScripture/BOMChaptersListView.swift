//
//  BOMChaptersListView.swift
//  DualScripture
//
//  Created by Michael Knight on 3/8/26.
//

import SwiftUI

struct BOMChaptersListView: View {
    @Binding var primaryLang: String
    @Binding var secondaryLang: String
    @State var chaptersCount: Int
    @State var bomBook: String

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    func changeChaptersCount() -> Void {
        chaptersCount = 3
        print(chaptersCount)
    }

    var body: some View {
        VStack {
            ZStack {
                VStack {

                }
                .frame(width: bomBook.count > 10 ? 350 : 230, height: 45)
                .background(.blue)
                .cornerRadius(12)
                .offset(x: 0, y: 2)
                Text(bomBook)
                    .foregroundStyle(Color.black)
                    .font(.custom("Poppins-Regular", size: 25))
                    .frame(width: bomBook.count > 10 ? 350 : 230, height: 45)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .versesBackground, .chapterBorder,
                                .chapterBorder, .chapterBorder, .chapterBorder,
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 0.4)
                    )
            }
            .padding(.bottom, 20)
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(1..<chaptersCount + 1, id: \.self) { chapter in
                            NavigationLink(
                                destination: VersesView(
                                    primaryLang: $primaryLang,
                                    secondaryLang: $secondaryLang,
                                    currentBook: $bomBook,
                                    currentChapter: chapter,
                                    totalChapters: $chaptersCount
                                )
                            ) {
                                Text("\(chapter)")
                                    .font(.custom("Poppins-Regular", size: 17))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 50, height: 50)
                            .background(.chapterButtons)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.chapterBorder, lineWidth: 1)  // 2. Apply border to same shape
                            )
                        }
                    }
                }
                .containerRelativeFrame(.horizontal) { length, axis in
                    return length * 0.9
                }
                .containerRelativeFrame(.vertical) { length, axis in
                    return length * 0.9
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 30)
    }
}

#Preview {
    BOMChaptersListView(
        primaryLang: .constant("Tagalog"),
        secondaryLang: .constant("English"),
        chaptersCount: 10,
        bomBook: "Mga Pulong Ni Mormon"
    )
}
