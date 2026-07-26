import Foundation
//
//  VersesView.swift
//  DualScripture
//
//  Created by Michael Knight on 3/6/26.
//
import SwiftUI

struct VersesView: View {
    var languages: [String] = ["Tagalog", "English", "Spanish", "Cebuano"]
    @State var primaryLang: String
    @State var secondaryLang: String
    @State var currentBook: String

    @State var verseData: [DualLanguageVerse] = []
    @State var currentChapter: String

    @State var showBooksList: Bool = false
    @State var totalChapters: Int = 5
    @State var showLanguages: Bool = false
    @State var showSecondaryLangOptions: Bool = false
    @State var showPrimaryLangOptions: Bool = false
    @State private var tempPLang: String = ""
    @State private var tempSLang: String = ""

    func getBooksList() -> [Book] {
        if primaryLang == "English" {
            return BOM_BOOKS
        } else if primaryLang == "Spanish" {
            return BOM_BOOKS_SPANISH
        } else if primaryLang == "Tagalog" {
            return BOM_BOOKS_TAGALOG
        } else {
            return BOM_BOOKS_CEBUANO
        }
    }
    
    func getCurrentBookNameByLanguage() -> String {
        var correctName = ""
        
        if primaryLang == "English" {
            correctName = standardizeName(bookName: currentBook)
        }
        
        
        return correctName
    }
    
    func showAbbreviation() -> String {
        var booksList = getBooksList()
        
        return booksList.filter({ $0.name == currentBook }).first?.abbreviation ?? ""
    }

    func getPrimaryFileName() -> String {
        switch primaryLang {
        case "English":
            return "book-of-mormon"
        case "Spanish":
            return "spanish-bom"
        case "Cebuano":
            return "cebuano-bom"
        default:
            return "tagalog-bom"
        }
    }
    
    func getSecondaryFileName() -> String {
        switch secondaryLang {
        case "English":
            return "book-of-mormon"
        case "Spanish":
            return "spanish-bom"
        case "Cebuano":
            return "cebuano-bom"
        default:
            return "tagalog-bom"
        }
    }
    
    func standardizeName(bookName: String) -> String {
        var standardizedBookName = ""

        switch bookName {
        case "1 Nefi", "1 Nephi":
            standardizedBookName = "1 Nephi"
        case "2 Nefi", "2 Nephi":
            standardizedBookName = "2 Nephi"
        case "Jacob":
            standardizedBookName = "Jacob"
        case "Enós", "Enos":
            standardizedBookName = "Enos"
        case "Jarom":
            standardizedBookName = "Jarom"
        case "Omni":
            standardizedBookName = "Omni"
        case "Palabras de Mormón", "Mga Salita ni Mormon", "Mga Pulong ni Mormon", "Words of Mormon":
            standardizedBookName = "Words of Mormon"
        case "Mosíah", "Mosiah":
            standardizedBookName = "Mosiah"
        case "Alma":
            standardizedBookName = "Alma"
        case "Helamán", "Helaman":
            standardizedBookName = "Helaman"
        case "3 Nefi", "3 Nephi":
            standardizedBookName = "3 Nephi"
        case "4 Nefi", "4 Nephi":
            standardizedBookName = "4 Nephi"
        case "Mormón", "Mormon":
            standardizedBookName = "Mormon"
        case "Éter", "Eter", "Ether":
            standardizedBookName = "Ether"
        case "Moroni":
            standardizedBookName = "Moroni"
        default:
            standardizedBookName = ""
        }
        
        return standardizedBookName
    }
    
    func correctBook(bookName: String) -> Bool {
        
        var standardizedBookName = standardizeName(bookName: currentBook)
        
        return standardizedBookName == bookName
    }

    func loadJSONFile(fileName: String) -> Data? {
        guard
            let url = Bundle.main.url(
                forResource: fileName,
                withExtension: "json"
            )
        else {
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
        if let jsonData = loadJSONFile(fileName: getSecondaryFileName()) {
            let decoder = JSONDecoder()

            do {
                engBOM = try decoder.decode(EnglishBOM.self, from: jsonData)
                // loop over the list and get the secondary language info
                for locBook in engBOM.books {
                    if correctBook(bookName: locBook.book) {
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
        if let jsonData = loadJSONFile(fileName: getPrimaryFileName()) {
            let decoder = JSONDecoder()

            do {
                tglBOM = try decoder.decode(EnglishBOM.self, from: jsonData)
                // we can use the index we found above to get there quickly
                var chapterIndex = Int(currentChapter) ?? 0
               
                tvd = tglBOM.books[bookIndex].chapters[chapterIndex - 1].verses

            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        var count = evd.count

        for i in 0..<count {
            verseData.append(
                DualLanguageVerse(
                    knownLangVerse: evd[i].text,
                    targetLangVerse: tvd[i].text,
                    showTargetLang: true,
                    verse: evd[i].verse
                )
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
            .background(.mint)
            .cornerRadius(12)
            .offset(x: -153, y: 369)
            VStack {

            }
            .frame(width: 60, height: 45)
            .background(.mint)
            .cornerRadius(12)
            .offset(x: 153, y: 369)
            VStack {
                ScrollView {
                    ForEach($verseData, id: \.self.verse) { $verse in
                        VStack {
                            HStack {
                                VStack {
                                    Text("\(verse.verse)")
                                        .font(
                                            .custom("Poppins-Regular", size: 13)
                                        )
                                        .frame(alignment: .bottomLeading)
                                        .foregroundStyle(.blue)
                                    Spacer()
                                }.frame(width: 20)
                                if !verse.showTargetLang {
                                    Divider()
                                        .frame(width: 5)
                                        .overlay(.mint)
                                        .cornerRadius(5)
                                }
                                Text(
                                    verse.showTargetLang
                                        ? verse.targetLangVerse
                                        : verse.knownLangVerse
                                )
                                .font(.custom("Inder-Regular", size: 18))
                                .foregroundStyle(.gray)
                                .onTapGesture {
                                    if !showBooksList && !showLanguages {
                                        withAnimation(
                                            .spring(.bouncy(duration: 0.3))
                                        ) {
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
                        .scrollContentBackground(.hidden)  // Hides the default list background
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
                            .stroke(.blue, lineWidth: 0.2)
                    )
                    HStack {
                        Text("\(showAbbreviation())")
                            .font(.custom("Poppins-Regular", size: 35))
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
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .versesBackground, .chapterBorder,
                                .chapterBorder, .chapterBorder, .chapterBorder,
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
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
                            .stroke(.blue, lineWidth: 0.2)
                    )
                }
                .frame(width: 370)
            }.frame(width: 450, height: 750)
                .padding(.top, 30)
                .onTapGesture {
                    showBooksList = false
                }
                .toolbar {
                    if !showLanguages {
                        ToolbarItem(placement: .navigationBarTrailing) {  // or .navigationBarLeading
                            Button {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    showLanguages = true
                                }
                            } label: {
                                Image(systemName: "translate")
                            }
                        }
                    }
                }
            if showLanguages {
                VStack {

                }
                .frame(
                    width: showLanguages ? 300 : 0,
                    height: showLanguages ? 150 : 0
                )
                .background(.mint)
                .cornerRadius(12)
                .offset(x: showLanguages ? 30 : 0, y: showLanguages ? -340 : 0)
                VStack {
                    if showLanguages {
                        VStack {
                            HStack(spacing: 20) {
                                VStack {
                                    Text("Primary Language")
                                        .font(
                                            .custom("Poppins-Regular", size: 13)
                                        )
                                        .foregroundStyle(.white)
                                    Button {
                                        showPrimaryLangOptions = true
                                    } label: {
                                        Text(tempPLang)
                                            .font(
                                                .custom(
                                                    "Poppins-Regular",
                                                    size: 13
                                                )
                                            )
                                            .foregroundStyle(.black)
                                    }
                                    .frame(width: 100, height: 40)
                                    .background(.mint.opacity(0.2))
                                    .cornerRadius(5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.mint, lineWidth: 1)  // 2. Apply border to same shape
                                    )
                                }

                                VStack {
                                    Text("Secondary Language")
                                        .font(
                                            .custom("Poppins-Regular", size: 13)
                                        )
                                        .foregroundStyle(.white)
                                    Button {
                                        showSecondaryLangOptions = true
                                    } label: {
                                        Text(tempSLang)
                                            .font(
                                                .custom(
                                                    "Poppins-Regular",
                                                    size: 13
                                                )
                                            )
                                            .foregroundStyle(.black)
                                    }
                                    .frame(width: 100, height: 40)
                                    .background(.mint.opacity(0.2))
                                    .cornerRadius(5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.mint, lineWidth: 1)  // 2. Apply border to same shape
                                    )
                                }
                            }
                            HStack {
                                Spacer()
                                HStack {
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.1))
                                        {
                                            tempPLang = primaryLang
                                            tempSLang = secondaryLang
                                            showLanguages = false
                                            showSecondaryLangOptions = false
                                            showPrimaryLangOptions = false
                                        }
                                    } label: {
                                        Text("CANCEL")
                                            .font(
                                                .custom(
                                                    "Poppins-Regular",
                                                    size: 12
                                                )
                                            )
                                            .foregroundStyle(.brown)
                                    }
                                    .frame(width: 80, height: 30)
                                    .cornerRadius(5)
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.1))
                                        {
                                            primaryLang = tempPLang
                                            secondaryLang = tempSLang
                                            tempPLang = primaryLang
                                            tempSLang = secondaryLang
                                            showLanguages = false
                                            showSecondaryLangOptions = false
                                            showPrimaryLangOptions = false
                                            
                                            currentBook = "HI"
                                        }
                                    } label: {
                                        Text("CHANGE")
                                            .font(
                                                .custom(
                                                    "Poppins-Regular",
                                                    size: 12
                                                )
                                            )
                                            .foregroundStyle(.blue)
                                    }
                                    .frame(width: 80, height: 30)
                                    .cornerRadius(5)

                                }
                            }
                            .padding(.top, 20)
                        }
                    } else {
                        Button {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showLanguages = true
                            }
                        } label: {
                            Image(systemName: "translate")
                                .font(.custom("Poppins-Regular", size: 25))
                                .foregroundStyle(.black)
                                .padding(8)
                        }
                    }
                }
                .frame(
                    width: showLanguages ? 300 : 60,
                    height: showLanguages ? 150 : 48
                )
                .background(Color.chapterBorder)

                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.mint, lineWidth: 0.2)
                )
                .offset(
                    x: showLanguages ? 30 : 150,
                    y: showLanguages ? -335 : -385
                )
                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 3, y: 4)
            }
            if showPrimaryLangOptions {
                VStack {
                    Text("English")
                        .font(.custom("Poppins-Regular", size: 20))
                        .frame(height: 30)
                        .foregroundStyle(.black)
                        .onTapGesture {
                            tempPLang = "English"
                            showPrimaryLangOptions = false
                        }
                    Text("Spanish")
                        .font(.custom("Poppins-Regular", size: 20))
                        .frame(height: 30)
                        .foregroundStyle(.black)
                        .onTapGesture {
                            tempPLang = "Spanish"
                            showPrimaryLangOptions = false
                        }
                    Text("Tagalog")
                        .font(.custom("Poppins-Regular", size: 20))
                        .frame(height: 30)
                        .foregroundStyle(.black)
                        .onTapGesture {
                            tempPLang = "Tagalog"
                            showPrimaryLangOptions = false
                        }
                    Text("Cebuano")
                        .font(.custom("Poppins-Regular", size: 20))
                        .frame(height: 30)
                        .foregroundStyle(.black)
                        .onTapGesture {
                            tempPLang = "Cebuano"
                            showPrimaryLangOptions = false
                        }
                }
                .frame(width: 100, height: 170)
                .background(.white)
                .offset(x: -50, y: -242)
            }
            if showSecondaryLangOptions {
                VStack {
                    Text("English")
                        .font(.custom("Poppins-Regular", size: 20))
                        .frame(height: 30)
                        .foregroundStyle(.black)
                        .onTapGesture {
                            tempSLang = "English"
                            showSecondaryLangOptions = false
                        }
                    Text("Spanish")
                        .font(.custom("Poppins-Regular", size: 20))
                        .frame(height: 30)
                        .foregroundStyle(.black)
                        .onTapGesture {
                            tempSLang = "Spanish"
                            showSecondaryLangOptions = false
                        }
                    Text("Tagalog")
                        .font(.custom("Poppins-Regular", size: 20))
                        .frame(height: 30)
                        .foregroundStyle(.black)
                        .onTapGesture {
                            tempSLang = "Tagalog"
                            showSecondaryLangOptions = false
                        }
                    Text("Cebuano")
                        .font(.custom("Poppins-Regular", size: 20))
                        .frame(height: 30)
                        .foregroundStyle(.black)
                        .onTapGesture {
                            tempSLang = "Cebuano"
                            showSecondaryLangOptions = false
                        }
                }
                .frame(width: 100, height: 170)
                .background(.white)
                .offset(x: 100, y: -242)
            }
            if showBooksList {
                VStack {
                    HStack {
                        ScrollViewReader { scrollView in
                            ScrollView {
                                ForEach(getBooksList(), id: \.self.name) {
                                    book in
                                    Text(book.abbreviation)
                                        .font(
                                            .custom("Poppins-Regular", size: 30)
                                        )
                                        .foregroundStyle(.black)
                                        .onTapGesture {
                                            withAnimation(
                                                .easeInOut(duration: 0.2)
                                            ) {
                                                currentBook = book.name
                                                totalChapters = 0
                                                totalChapters =
                                                    book.chapterCount
                                                currentChapter = "1"
                                            }
                                            //showBooksList = false
                                            // then update the chapters list based on what I just clicked
                                        }
                                        .frame(width: 270, height: 40)
                                        .background(
                                            book.name == currentBook
                                                ? .mint.opacity(0.1)
                                                : .chapterBorder
                                        )
                                        .cornerRadius(10)
                                        .padding(
                                            book.name == currentBook ? 5 : 0
                                        )
                                }
                            }
                            .frame(width: 280, height: 450)

                            .onAppear {
                                scrollView.scrollTo(
                                    currentBook,
                                    anchor: .center
                                )
                            }
                        }
                        Divider()
                            .frame(width: 2)
                            .overlay(.black)

                        ScrollView {
                            ForEach(0..<totalChapters, id: \.self) { chapter in
                                Text("\(chapter + 1)")
                                    .font(.custom("Poppins-Regular", size: 30))
                                    .transition(.move(edge: .bottom))
                                    .foregroundStyle(.mint.opacity(0.2))
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.2))
                                        {
                                            currentChapter = String(chapter + 1)
                                            showBooksList = false
                                        }
                                    }
                                    .padding(.trailing, 25)
                            }
                        }
                        .frame(width: showBooksList ? 80 : 0, height: 440)
                        .transition(.move(edge: .trailing))
                    }
                    .frame(height: 450)
                }
                .frame(width: 380, height: 460)
                .cornerRadius(30)
                .background(
                    Color.chapterBorder.shadow(
                        color: Color.black.opacity(0.5),
                        radius: 2,
                        x: 3,
                        y: 4
                    )
                )
                .offset(x: 0, y: 100)
                .transition(.scale(scale: 0.1))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Make the frame
        .background(.versesBackground)
        .ignoresSafeArea()
        .onAppear {
            getBOMData()
            showBooksList = false
            showLanguages = false
            showPrimaryLangOptions = false
            showSecondaryLangOptions = false
            tempPLang = primaryLang
            tempSLang = secondaryLang
        }

    }
}

#Preview {
    VersesView(
        primaryLang: "Spanish",
        secondaryLang: "English",
        currentBook: "Jarom",
        currentChapter: "1"
    )
}
