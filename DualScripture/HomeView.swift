//
//  ContentView.swift
//  DualScripture
//
//  Created by Michael Knight on 1/14/26.
//

import SwiftUI
import Foundation
import SwiftSoup

//var tagalogBOM: JS =
//{
//    "1 Nephi": {
//        "heading": "",
//        "1": {
//            "1": "",
//            "2": ""
//        },
//        "2": {
//            "1": "",
//            "2": ""
//        }
//    },
//    "2 Nephi": {
//        "heading": "",
//        "1": {
//            
//        }
//    }
//}


var scripture1 = ScriptureVerse(targetLangVerse: "At siya ay naglakbay sa may mga hangganang malapit sa dalampasigan ng Dagat na Pula; at siya ay naglakbay sa ilang sa mga hangganang mas malapit sa Dagat na Pula; at siya ay naglakbay sa ilang kasama ang kanyang mag-anak, na binubuo ng aking inang si Saria, at ng mga nakatatanda kong kapatid na sina Laman, Lemuel, at Sam.", showTargetLang: true, knownLangVerse: "And he came down by the borders near the shore of the Red Sea; and he traveled in the wilderness in the borders which are nearer the Red Sea; and he did travel in the wilderness with his family, which consisted of my mother, Sariah, and my elder brothers, who were Laman, Lemuel, and Sam.", verseNumber: "1")

var scripture2 = ScriptureVerse(targetLangVerse: "At ngayon, ito ay nangyari na pagkaraang ako, si Nephi, ay matapos sa pagtuturo sa aking mga kapatid, ang aming amang si Lehi ay nangusap din ng maraming bagay sa kanila, at inulit sa kanila kung gaano kadakila ang mga bagay na ginawa ng Panginoon para sa kanila sa paglalabas sa kanila sa lupain ng Jerusalem.", showTargetLang: true, knownLangVerse: "And he came down by the borders near the shore of the Red Sea; and he traveled in the wilderness in the borders which are nearer the Red Sea; and he did travel in the wilderness with his family, which consisted of my mother, Sariah, and my elder brothers, who were Laman, Lemuel, and Sam.", verseNumber: "2")

var scripture3 = ScriptureVerse(targetLangVerse: "Samakatwid, ako, si Lehi, ay nagpopropesiya alinsunod sa pamamatnubay ng Espiritu na nasa akin, na walang ibang makapaparito sa lupaing ito maliban sa sila ay dalhin ng kamay ng Panginoon.", showTargetLang: true, knownLangVerse: "And he came down by the borders near the shore of the Red Sea; and he traveled in the wilderness in the borders which are nearer the Red Sea; and he did travel in the wilderness with his family, which consisted of my mother, Sariah, and my elder brothers, who were Laman, Lemuel, and Sam.", verseNumber: "3")

var scripture4 = ScriptureVerse(targetLangVerse: "At dinggin, ito ay karunungan na ikubli muna ang lupain sa kaalaman ng mga ibang bansa; sapagkat dinggin, maraming bansa ang sasakop sa lupain, kung kaya’t hindi magkakaroon ng pook na ipamamana.", showTargetLang: true, knownLangVerse: "And he came down by the borders near the shore of the Red Sea; and he traveled in the wilderness in the borders which are nearer the Red Sea; and he did travel in the wilderness with his family, which consisted of my mother, Sariah, and my elder brothers, who were Laman, Lemuel, and Sam.", verseNumber: "4")

struct Verse: Codable {
    var number: String;
    var text: String
}

struct HomeView: View {
    @State var showingTargetLanguage: Bool = true
    @State var verseData: [DualLanguageVerse] = []
    @State var verses: [ScriptureVerse] = [scripture1, scripture2, scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3]
    @State var verses2: [ScriptureVerse] = [scripture3, scripture3, scripture3, scripture3]
    @State var verses3: [ScriptureVerse] =  [scripture1, scripture2, scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3,scripture3]
    
    @State var currentChapter: [ScriptureVerse] = []
    
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
            }.frame(width: 450, height: 690)
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
    HomeView()
}
