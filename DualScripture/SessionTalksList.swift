//
//  SessionTalksList.swift
//  DualScripture
//
//  Created by Michael Knight on 10/10/26.
//

import SwiftUI

struct SessionTalksList: View {
    @Binding var primaryLang: String
    @Binding var secondaryLang: String
    typealias ConferenceData = [String: [Session]]
    
    func loadJSONFile(fileName: String) -> Data? {
        guard
            let url = Bundle.main.url(
                forResource: fileName,
                withExtension: "json"
            )
        else {
            fatalError("Failed to locate General Conference.json in bundle")
        }
        do {
            return try Data(contentsOf: url)

        } catch {
            fatalError("Failed to load file from bundle: \(error)")
        }
    }
    
    func getConferenceTalksList() -> [String] {
        let talks: [String] = []
        
        // primary language
        if let jsonData = loadJSONFile(fileName: "tagalog-oct-2026") {
            let decoder = JSONDecoder()

            do {
                let conferenceData = try decoder.decode(ConferenceData.self, from: jsonData)
                // we can use the index we found above to get there quickly
//                let chapterIndex = currentChapter
//               
//                tvd = tglBOM.books[bookIndex].chapters[chapterIndex - 1].verses
                if let sessions = conferenceData["oct-2026"] {
                    for session in sessions {
                        print("Session Number: \(session.number)")
                        for talk in session.talks {
                            print("Talk Title: \(talk.title)")
                            print("Author: \(talk.author)")
                        }
                    }
                }

            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        return talks
    }
    var body: some View {
        VStack {
            
            Text("text")
        }.onAppear {
            getConferenceTalksList()
        }
    }
//        VStack {
//            List {
//                ForEach (getBooksList(), id: \.self.name) { book in
//                    
//                    if book.chapterCount > 1 {
//                        NavigationLink(destination: BOMChaptersListView(primaryLang: $primaryLang, secondaryLang: $secondaryLang, chaptersCount: book.chapterCount, bomBook: book.name)) {
//                            HStack {
//                                VStack() {
//                                    Spacer()
//                                    Text(book.name)
//                                        .font(.custom("Inder-Regular", size: 20))
//                                        .foregroundStyle(.white)
//                                        .padding(.top, -16)
//                                }
//                                Spacer()
//                                if book.chapterCount > 1 {
//                                    Button {
//                                    } label: {
//                                        Image(systemName: "chevron.right")
//                                            .foregroundStyle(.gray)
//                                    }
//                                }
//                            }
//                            
//                        }
//                        .listRowBackground(Color.black)
//                        .navigationLinkIndicatorVisibility(.hidden)
//                    } else {
//                        NavigationLink(destination: BOMChaptersListView(primaryLang: $primaryLang, secondaryLang: $secondaryLang, chaptersCount: book.chapterCount, bomBook: book.name)) {
//                            HStack {
//                                VStack() {
//                                    Spacer()
//                                    Text(book.name)
//                                        .font(.custom("Inder-Regular", size: 20))
//                                        .foregroundStyle(.white)
//                                        .padding(.top, -16)
//                                }
//                                Spacer()
//                                if book.chapterCount > 1 {
//                                    Button {
//                                        // take to the chapter
//                                    } label: {
//                                        Image(systemName: "chevron.right")
//                                            .foregroundStyle(.gray)
//                                    }
//                                }
//                            }
//                            
//                        }
//                        .listRowBackground(Color.black)
//                        .navigationLinkIndicatorVisibility(.hidden)
//                    }
//
//                }
//            }
//            .scrollContentBackground(.hidden)
//            .background(.black)
//        }
//    }
}

#Preview {
    SessionTalksList(primaryLang: .constant("Tagalog"), secondaryLang: .constant("English"))
}
