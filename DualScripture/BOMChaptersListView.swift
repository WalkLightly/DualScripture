//
//  BOMChaptersListView.swift
//  DualScripture
//
//  Created by Michael Knight on 3/8/26.
//

import SwiftUI

struct BOMChaptersListView: View {
    @State var chaptersCount: Int
    @State var bomBook: String = "1 Nephi"
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    
                }
                .frame(width: 230, height: 45)
                .background(.blue)
                .cornerRadius(12)
                .offset(x: 0, y: 2)
                Text(bomBook)
                    .foregroundStyle(Color.black)
                    .font(.custom("Poppins-Regular", size: 30))
                    .frame(width: 230, height: 45)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.versesBackground, .chapterBorder, .chapterBorder, .chapterBorder, .chapterBorder]),startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 0.4)
                    )
            }
            .padding(.bottom, 20)
            
            HStack {
                ForEach (1..<chaptersCount) { chapter in
                    if chapter < 7 {
                        NavigationLink(destination: VersesView(currentBook: bomBook, currentChapter: String(chapter))) {
                            Text("\(chapter)")
                                .font(.custom("Poppins-Regular", size: 17))
                                .foregroundStyle(.white)
                        }
                        .frame(width: 55, height: 55)
                        .background(.chapterButtons)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.chapterBorder, lineWidth: 1) // 2. Apply border to same shape
                        )
                    }
                }
            }
            if chaptersCount > 6 {
                HStack {
                    ForEach (7..<13) { chapter in
                        if chapter <= chaptersCount {
                            NavigationLink(destination: VersesView(currentBook: bomBook, currentChapter: String(chapter))) {
                                Text("\(chapter)")
                                    .font(.custom("Poppins-Regular", size: 17))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 55, height: 55)
                            .background(.chapterButtons)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.chapterBorder, lineWidth: 1) // 2. Apply border to same shape
                            )
                        }
                    }
                }
            }
            if chaptersCount > 12 {
                HStack {
                    ForEach (13..<19) { chapter in
                        if chapter <= chaptersCount {
                            NavigationLink(destination: VersesView(currentBook: bomBook, currentChapter: String(chapter))) {
                                Text("\(chapter)")
                                    .font(.custom("Poppins-Regular", size: 17))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 55, height: 55)
                            .background(.chapterButtons)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.chapterBorder, lineWidth: 1) // 2. Apply border to same shape
                            )
                        }
                    }
                }
            }
            if chaptersCount > 18 {
                HStack {
                    ForEach (19..<25) { chapter in
                        if chapter <= chaptersCount {
                            NavigationLink(destination: VersesView(currentBook: bomBook, currentChapter: String(chapter))) {
                                Text("\(chapter)")
                                    .font(.custom("Poppins-Regular", size: 17))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 55, height: 55)
                            .background(.chapterButtons)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.chapterBorder, lineWidth: 1) // 2. Apply border to same shape
                            )
                        }
                    }
                }
            }
            if chaptersCount > 24 {
                HStack {
                    ForEach (25..<31) { chapter in
                        if chapter <= chaptersCount {
                            NavigationLink(destination: VersesView(currentBook: bomBook, currentChapter: String(chapter))) {
                                Text("\(chapter)")
                                    .font(.custom("Poppins-Regular", size: 17))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 55, height: 55)
                            .background(.chapterButtons)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.chapterBorder, lineWidth: 1) // 2. Apply border to same shape
                            )
                        }
                    }
                }
            }
            if chaptersCount > 30 {
                HStack {
                    ForEach (31..<37) { chapter in
                        if chapter <= chaptersCount {
                            NavigationLink(destination: VersesView(currentBook: bomBook, currentChapter: String(chapter))) {
                                Text("\(chapter)")
                                    .font(.custom("Poppins-Regular", size: 17))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 55, height: 55)
                            .background(.chapterButtons)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.chapterBorder, lineWidth: 1) // 2. Apply border to same shape
                            )
                        }
                    }
                }
            }
            if chaptersCount > 36 {
                HStack {
                    ForEach (37..<43) { chapter in
                        if chapter <= chaptersCount {
                            NavigationLink(destination: VersesView(currentBook: bomBook, currentChapter: String(chapter))) {
                                Text("\(chapter)")
                                    .font(.custom("Poppins-Regular", size: 17))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 55, height: 55)
                            .background(.chapterButtons)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.chapterBorder, lineWidth: 1) // 2. Apply border to same shape
                            )
                        }
                    }
                }
            }
            if chaptersCount > 42 {
                HStack {
                    ForEach (43..<49) { chapter in
                        if chapter <= chaptersCount {
                            NavigationLink(destination: VersesView(currentBook: bomBook, currentChapter: String(chapter))) {
                                Text("\(chapter)")
                                    .font(.custom("Poppins-Regular", size: 17))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 55, height: 55)
                            .background(.chapterButtons)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.chapterBorder, lineWidth: 1) // 2. Apply border to same shape
                            )
                        }
                    }
                }
            }
            if chaptersCount > 48 {
                HStack {
                    ForEach (49..<55) { chapter in
                        if chapter <= chaptersCount {
                            NavigationLink(destination: VersesView(currentBook: bomBook, currentChapter: String(chapter))) {
                                Text("\(chapter)")
                                    .font(.custom("Poppins-Regular", size: 17))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 55, height: 55)
                            .background(.chapterButtons)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.chapterBorder, lineWidth: 1) // 2. Apply border to same shape
                            )
                        }
                    }
                }
            }
            if chaptersCount > 54 {
                HStack {
                    ForEach (55..<61) { chapter in
                        if chapter <= chaptersCount {
                            NavigationLink(destination: VersesView(currentBook: bomBook, currentChapter: String(chapter))) {
                                Text("\(chapter)")
                                    .font(.custom("Poppins-Regular", size: 17))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 55, height: 55)
                            .background(.chapterButtons)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.chapterBorder, lineWidth: 1) // 2. Apply border to same shape
                            )
                        }
                    }
                }
            }
            if chaptersCount > 60 {
                HStack {
                    ForEach (61..<67) { chapter in
                        if chapter <= chaptersCount {
                            NavigationLink(destination: VersesView(currentBook: bomBook, currentChapter: String(chapter))) {
                                Text("\(chapter)")
                                    .font(.custom("Poppins-Regular", size: 17))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 55, height: 55)
                            .background(.chapterButtons)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.chapterBorder, lineWidth: 1) // 2. Apply border to same shape
                            )
                        }
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 30)
    }
}

#Preview {
    BOMChaptersListView(chaptersCount: 7)
}
