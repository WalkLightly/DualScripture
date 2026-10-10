//
//  SessionTalksList.swift
//  DualScripture
//
//  Created by Michael Knight on 10/10/26.
//

import SwiftUI

struct ConferenceTalkListItem: Hashable {
    let itemType: String
    let title: String
    let author: String
    let calling: String
    let subject: String
    let paragraphs: [String]
}

var sessionNameMap: [String: String] = [
    "1": "Saturday Morning Session",
    "2": "Saturday Afternoon Session",
    "3": "Sunday Morning Session",
    "4": "Sunday Afternoon Session"
]

struct SessionTalksList: View {
    
    @Binding var primaryLang: String
    @Binding var secondaryLang: String
    typealias ConferenceData = [String: [Session]]
    @State private var primaryLangData: [ConferenceTalkListItem] = []
    let chosenMonth: String
    
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
        primaryLangData = []
        
        // primary language
        if let jsonData = loadJSONFile(fileName: "tagalog-oct-2026") {
            let decoder = JSONDecoder()

            do {
                let tempData: ConferenceData = try decoder.decode(ConferenceData.self, from: jsonData)
                // we can use the index we found above to get there quickly
//                let chapterIndex = currentChapter
//               
//                tvd = tglBOM.books[bookIndex].chapters[chapterIndex - 1].verses
                if let sessions = tempData["oct-2026"] {
                    for session in sessions {
                        primaryLangData.append(ConferenceTalkListItem(itemType: "Header", title: sessionNameMap[session.number] ?? "", author: "", calling: "", subject: "", paragraphs: []))
                        for talk in session.talks {
                            primaryLangData.append(ConferenceTalkListItem(itemType: "Talk", title: talk.title, author: talk.author, calling: talk.calling, subject: talk.subject, paragraphs: talk.paragraphs))
                        }
                    }
                }
                
                print(primaryLangData)

            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        return talks
    }
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Text(chosenMonth)
                        .foregroundStyle(Color.black)
                        .font(.custom("Poppins-Regular", size: 25))
                        .padding(.horizontal, 15)
                }
                .frame(height: 45)
                .background(.blue)
                .cornerRadius(12)
                .offset(x: 0, y: 5)
                VStack {
                    Text(chosenMonth)
                        .foregroundStyle(Color.black)
                        .font(.custom("Poppins-Regular", size: 25))
                        .padding(.horizontal, 15)
                }
                .frame(height: 50)
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
                        .stroke(.blue, lineWidth: 0.5)
                )
            }
            .padding(.bottom, 20)
            VStack {
                
                List(Array(primaryLangData.enumerated()), id: \.offset) { index, talkListItem in
                    VStack {
                        if talkListItem.itemType == "Header" {
                            HStack {
                                Text(talkListItem.title)
                                    .font(.custom("Poppins-Bold", size: 25))
                                    .foregroundStyle(.mint)
                                Spacer()
                            }
                            .frame(height: 50)
                            .padding(.leading, 15)
                            .background(.mint.opacity(0.2))
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.mint, lineWidth: 2)
                            }
                        } else {
                            NavigationLink(destination: ConferenceTalkView(primaryLang: $primaryLang, secondaryLang: $secondaryLang, conferenceTalk: talkListItem)) {
                                
                                HStack {
                                    Text(talkListItem.title)
                                        .font(.custom(talkListItem.itemType == "Header" ? "Poppins-Bold" : "Poppins-Regular", size: talkListItem.itemType == "Header" ? 20 : 16))
                                        .foregroundStyle(talkListItem.itemType == "Header" ? .mint : .white)
                                    Spacer()
                                }
                                .padding(.leading, 15)
                            }
                        }
                        
                        if talkListItem.itemType == "Talk" {
                            HStack {
                                Text(talkListItem.author)
                                    .font(.custom("Poppins-Regular", size: 13))
                                    .foregroundStyle(.gray)
                                
                                Spacer()
                            }
                            .padding(.leading, 15)
                        }
                    }
                    //.listRowSeparator(.hidden)                  // 1. Hide line separators between rows
                    .listRowBackground(Color.clear)            // 2. Remove default row background
                    .listRowInsets(EdgeInsets(top: 8, leading: talkListItem.itemType == "Header" ? 0 : 20, bottom: 8, trailing: 0)) // 3. Custom padding/margins
                    .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                }
                .listStyle(.plain)                                 // 4. Removes grouped/inset style margins
                .scrollContentBackground(.hidden)
            }.onAppear {
                getConferenceTalksList()
            }
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
    SessionTalksList(primaryLang: .constant("Tagalog"), secondaryLang: .constant("English"), chosenMonth: "Oct-2026")
}
