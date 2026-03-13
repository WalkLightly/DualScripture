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
    @State var currentBook: String = "Jarom"
    @State var currentChapter: String = "1"
    
    @State var showBooksList: Bool = false
    @State var totalChapters: Int = 5
       
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
        
        // init the chapters count for the selected book
        
        var engBOM: EnglishBOM
        var tglBOM: EnglishBOM
        
        var bookIndex = 0
        
        var evd: [VerseEng] = []
        var tvd: [VerseEng] = []
        // secondary language
        if let jsonData = loadJSONFile(fileName: "book-of-mormon") {
            let decoder = JSONDecoder()
            
            do {
                engBOM = try decoder.decode(EnglishBOM.self, from: jsonData)
                // loop over the list and get the secondary language info
                for locBook in engBOM.books {
                    if locBook.book == currentBook {
                        break
                    }
                    bookIndex += 1
                }
                
                var chapterIndex = Int(currentChapter) ?? 0
                evd = engBOM.books[bookIndex].chapters[chapterIndex - 1].verses
                
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        // primary language
        if let jsonData = loadJSONFile(fileName: "tagalog-bom") {
            let decoder = JSONDecoder()
            
            do {
                tglBOM = try decoder.decode(EnglishBOM.self, from: jsonData)
                // we can use the index we found above to get there quickly
                var chapterIndex = Int(currentChapter) ?? 0
                print(bookIndex)
                print(chapterIndex)
                tvd = tglBOM.books[bookIndex].chapters[chapterIndex - 1].verses
                
                
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
            .offset(y: 369)
            VStack {
                
            }
            .frame(width: 60, height: 45)
            .background(.blue)
            .cornerRadius(12)
            .offset(x: -153, y: 369)
            VStack {
                
            }
            .frame(width: 60, height: 45)
            .background(.blue)
            .cornerRadius(12)
            .offset(x: 153, y: 369)
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
                                        if !showBooksList {
                                            withAnimation(.smooth(duration: 0.3)) {
                                                verse.showTargetLang.toggle()
                                               
                                            }
                                        }
                                        showBooksList = false
                                        
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
                    HStack {
                        Text("\(currentBook)")
                            .font(.custom("Poppins-Regular", size: 30))
                            .foregroundStyle(.black)
                            
                        Text(":")
                            .font(.custom("Poppins-Regular", size: 30))
                            .foregroundStyle(.black)
                        Text("\(currentChapter)")
                            .font(.custom("Poppins-Regular", size: 30))
                            .foregroundStyle(.black)
                    }
                    .frame(width: 230, height: 45)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.versesBackground, .chapterBorder, .chapterBorder, .chapterBorder, .chapterBorder]),startPoint: .top, endPoint: .bottom)
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 0.2)
                    )
                    .onTapGesture {
                        showBooksList = true
                    }
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
            .padding(.top, 30)
            .onTapGesture {
                showBooksList = false
            }
            if showBooksList {
                VStack {
                    HStack {
                        ScrollViewReader { scrollView in
                            ScrollView {
                                ForEach(BOM_BOOKS, id: \.self.name) { book in
                                    Text(book.abbreviation)
                                        .font(.custom("Poppins-Regular", size: 30))
                                        .foregroundStyle(.black)
                                        .onTapGesture {
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                currentBook = book.abbreviation
                                                totalChapters = 0
                                                totalChapters = book.chapterCount
                                            }
                                            //showBooksList = false
                                            // then update the chapters list based on what I just clicked
                                        }
                                        .frame(width: 270, height: 40)
                                        .background(book.name == currentBook ? .blue.opacity(0.1) : .chapterBorder)
                                        .cornerRadius(10)
                                        .padding(book.name == currentBook ? 5 : 0)
                                }
                            }
                            .frame(width: 280, height: 450)
                            
                            .onAppear {
                                scrollView.scrollTo(currentBook, anchor: .center)
                            }
                        }
                        Divider()
                            .overlay(.blue)
                        
                        ScrollView() {
                            ForEach(0..<totalChapters, id: \.self) { chapter in
                                Text("\(chapter + 1)")
                                    .font(.custom("Poppins-Regular", size: 30))
                                    .transition(.move(edge: .bottom))
                                    .foregroundStyle(.white)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            currentChapter = String(chapter + 1)
                                            showBooksList = false
                                        }
                                    }
                                   .padding(.trailing, 25)
                            }
                        }
                        .frame(width: 80, height: 440)
//                        .background(Color.chapterBorder.shadow(color: Color.black.opacity(0.5), radius: 2, x: 3, y: 4))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 1)
//                                .stroke(.black.opacity(0.3), lineWidth: 0.1)
//                        )
                        
                    }
                    .frame(height: 450)
                }
                .frame(width: 380, height: 460)
                .cornerRadius(30)
                .background(Color.chapterBorder.shadow(color: Color.black.opacity(0.5), radius: 2, x: 3, y: 4))
                .offset(x: 0, y: 100)
              .transition(.scale(scale: 0.1))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Make the frame
        .background(.versesBackground)
        .ignoresSafeArea()
        .onAppear() {
            getBOMData()
            showBooksList = true
        }
       
    }
}

#Preview {
    VersesView()
}

