//
//  VersesView.swift
//  DualScripture
//
//  Created by Michael Knight on 3/6/26.
//
import SwiftUI
import Foundation

struct VersesView: View {
    @State var verseData: [DualLanguageVerse] = []
    @State var currentBook: String = "Words of M"
    @State var currentChapter: String = "4"
    
    @State var showChaptersList: Bool = false
    @State var showBooksList: Bool = false
    @State var totalChapters: Int = 10
       
    func loadJSONFile(fileName: String) -> Data? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
               fatalError("Failed to locate book-of-mormon.json in bundle")
           }
           do {
               return try Data(contentsOf: url)
              
           } catch {
               fatalError("Failed to load file from bundle: \(error)")
           }
    }
    
    func getBOMData() {
        var engBOM: EnglishBOM
        var tglBOM: EnglishBOM
        
        var evd: [VerseEng] = []
        var tvd: [VerseEng] = []
        
        // english
        if let jsonData = loadJSONFile(fileName: "book-of-mormon") {
            let decoder = JSONDecoder()
            
            do {
                engBOM = try decoder.decode(EnglishBOM.self, from: jsonData)
                evd = engBOM.books[0].chapters[0].verses
                
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        // tagalog
        if let jsonData = loadJSONFile(fileName: "tagalog-bom") {
            let decoder = JSONDecoder()
            
            do {
                tglBOM = try decoder.decode(EnglishBOM.self, from: jsonData)
                tvd = tglBOM.books[0].chapters[0].verses
                
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        var count = evd.count
        
        for i in 0..<count {
            verseData.append(
                DualLanguageVerse(knownLangVerse: evd[i].text, targetLangVerse: tvd[i].text, showTargetLang: true, verse: evd[i].verse)
            )
        }
        
    }

    var body: some View {
        ZStack {
            
            VStack {
                
            }
            .frame(width: 230, height: 45)
            .background(.blue)
            .cornerRadius(12)
            .offset(y: 365)
            VStack {
                
            }
            .frame(width: 60, height: 45)
            .background(.blue)
            .cornerRadius(12)
            .offset(x: -153, y: 365)
            VStack {
                
            }
            .frame(width: 60, height: 45)
            .background(.blue)
            .cornerRadius(12)
            .offset(x: 153, y: 365)
            VStack {
                ScrollView {
                    ForEach($verseData, id: \.self.verse) { $verse in
                        VStack {
                            HStack {
                                VStack {
                                    Text("\(verse.verse)")
                                        .font(.custom("Poppins-Regular", size: 12))
                                        .frame(alignment: .bottomLeading)
                                        .foregroundStyle(.blue)
                                    Spacer()
                                }.frame(width: 20)
                                Text(verse.showTargetLang ? verse.targetLangVerse : verse.knownLangVerse)
                                    .font(.custom("Poppins-Regular", size: 15))
                                    .foregroundStyle(.gray)
                                    .onTapGesture {
                                        if !showBooksList && !showChaptersList {
                                            withAnimation(.smooth(duration: 0.3)) {
                                                verse.showTargetLang.toggle()
                                               
                                            }
                                        }
                                        showBooksList = false
                                        showChaptersList = false
                                        
                                    }
                                Spacer()
                                
                            }
                            .frame(width: 380)
                            .padding(2)
                            
                        }
                        .background(Color.clear)
                    }.frame(width: 450)
                        .scrollContentBackground(.hidden) // Hides the default list background
                        .background(Color.clear)
                }
                Spacer()
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.custom("Poppins-Regular", size: 30))
                            .foregroundStyle(.black)
                            .padding(8)
                    }
                    .frame(width: 60)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.versesBackground, .chapterBorder, .chapterBorder, .chapterBorder, .chapterBorder]),startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 0.2)
                    )

//                    .overlay(
//                        RoundedRectangle(cornerRadius: 5)
//                            .stroke(.blue, lineWidth: 1) // 2. Apply border to same shape
//                    )
                    HStack {
                        Text("\(currentBook)")
                            .font(.custom("Poppins-Regular", size: 30))
                            .foregroundStyle(.black)
                            .onTapGesture {
                                showBooksList = true
                                showChaptersList = false
                            }
                        Text(":")
                            .font(.custom("Poppins-Regular", size: 30))
                            .foregroundStyle(.black)
                        Text("\(currentChapter)")
                            .font(.custom("Poppins-Regular", size: 30))
                            .foregroundStyle(.black)
                            .onTapGesture {
                                showChaptersList = true
                                showBooksList = false
                            }
                    }
                    .frame(width: 230, height: 45)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.versesBackground, .chapterBorder, .chapterBorder, .chapterBorder, .chapterBorder]),startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 0.2)
                    )
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.custom("Poppins-Regular", size: 30))
                            .foregroundStyle(.black)
                            .padding(8)
                    }
                    .frame(width: 60)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.versesBackground, .chapterBorder, .chapterBorder, .chapterBorder, .chapterBorder]),startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 0.2)
                    )
                }
                .frame(width: 370)
            }.frame(width: 450, height: 750)
            .padding(.top, 20)
            .onTapGesture {
                showBooksList = false
                showChaptersList = false
            }
            if showBooksList {
                ScrollView {
                    ForEach(BOM_BOOKS, id: \.self.name) { book in
                        Text(book.abbreviation)
                            .font(.custom("Poppins-Regular", size: 30))
                            .foregroundStyle(.black)
                            .onTapGesture {
                                currentBook = book.abbreviation
                                showBooksList = false
                                // then update the chapters list based on what I just clicked
                            }
                    }
                }
                .frame(width: 150, height: 400)
                .background(.regularMaterial)
                .offset(x: -40, y: 140)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.blue, lineWidth: 1)
                        .offset(x: -40, y: 140)// 2. Apply border to same shape
                )
            }
            if showChaptersList {
                ScrollView {
                    ForEach(1..<totalChapters) { chapter in
                        Text("\(chapter)")
                            .font(.custom("Poppins-Regular", size: 30))
                            .foregroundStyle(.black)
                            .onTapGesture {
                                currentChapter = String(chapter)
                                showChaptersList = false
                            }
                    }
                }
                .frame(width: 50, height: 200)
                .background(.regularMaterial)
                .offset(x: 80, y: 240)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.blue, lineWidth: 1)
                        .offset(x: 80, y: 240)// 2. Apply border to same shape
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Make the frame
        .background(.versesBackground)
        .ignoresSafeArea()
        .onAppear() {
            getBOMData()
            showChaptersList = false
            showBooksList = false
        }
       
    }
}

#Preview {
    VersesView()
}

