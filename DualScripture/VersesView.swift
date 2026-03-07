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
       
    func loadJSONFile(fileName: String) -> Data? {
//        let fileUrl = URL(filePath: "/Users/michaelknight/Documents/XcodeProjects/Bookshelf/Bookshelf/Data/BooksListCSV.csv")
//        do {
//            let fileContent = try String(contentsOf: fileUrl, encoding: .json)
//        } catch {
//
//        }
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
    
    func saveAsJson() -> Void {
//        let data = NSJSONSerialization.dataWithJSONObject(array, options: nil, error: nil)
//        let string = NSString(data: data!, encoding: NSUTF8StringEncoding)
    }
    
    
//    init() {
//        Task {
//            var vs: [Verse] = []
//            let response = URL(string: "https://www.churchofjesuschrist.org/study/scriptures/bofm/2-ne/1?lang=tgl")!
//            let html = try String(contentsOf: response)
//
//            // parse the HTML content
//            let document = try SwiftSoup.parse(html)
//            let htmlProducts = try document.select("p.verse")
//            var verseNum = 1
//            let title = try document.select("span.dominant").text()
//            let intro = try document.select("p.intro").text()
//
//            print(title)
//            print(intro)
//            for htmlProduct in htmlProducts.array() {
//                var v = try htmlProduct.text()
//                vs.append(Verse(number: String(verseNum), text: String(v.dropFirst(2).trimmingCharacters(in: .whitespacesAndNewlines))))
//                verseNum += 1
//            }
//            for v2 in vs {
//                print(v2)
//            }
//        }
//    }

    var body: some View {
        ZStack {
            VStack {
                Button("1 Nephi 1") {
                    
                }
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
                                        withAnimation(.smooth(duration: 0.3)) {
                                            verse.showTargetLang.toggle()
                                        }
                                    }
                                Spacer()
                                
                            }
                            .frame(width: 380)
                            .padding(2)
                            
                        }
                        .background(Color.clear)
                        //                    .swipeActions( edge: .trailing) {
                        //                        Button {
                        //                            verses = verses2
                        //                        } label: {
                        //                            Image(systemName: "chevron.right")
                        //                        }
                        //                    }
                        //                    .swipeActions(edge: .leading) {
                        //                        Button {
                        //                            verses = verses3
                        //                        } label: {
                        //                            Image(systemName: "chevron.left")
                        //                        }
                        //}
                    }.frame(width: 450)
                        .scrollContentBackground(.hidden) // Hides the default list background
                        .background(Color.clear)
                }
                Spacer()
            }.frame(width: 450, height: 750)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Make the frame
        .background(.mainBackground)
        .ignoresSafeArea()
        .onAppear() {
            getBOMData()
        }
    }
}

#Preview {
    VersesView()
}

