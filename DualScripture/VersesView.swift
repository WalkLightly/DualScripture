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
    @Binding var primaryLang: String
    @Binding var secondaryLang: String
    @Binding var currentBook: String
    @State var currentChapter: Int

    @State var verseData: [DualLanguageVerse] = []

    @State var showBooksList: Bool = false
    @Binding var totalChapters: Int
    @State var showLanguages: Bool = false
    @State var showSecondaryLangOptions: Bool = false
    @State var showPrimaryLangOptions: Bool = false
    @State private var tempPLang: String = ""
    @State private var tempSLang: String = ""
    @State private var bookIndex: Int = 0
    
    
    func translateName() -> Void {
        
        // first translate to english
        let standard = standardizeName(bookName: currentBook)
        
        // then translate to newly selected target language
        currentBook = translateBookName(standardBookName: standard)
    }
    
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
        let booksList = getBooksList()
        
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
        
        let standardizedBookName = standardizeName(bookName: currentBook)
        
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

    func getBOMData(resetBookIndex: Bool = false) {

        // init the chapters count for the selected book
        verseData = []
        var engBOM: EnglishBOM
        var tglBOM: EnglishBOM

        if resetBookIndex {
            bookIndex = 0
        }

        var evd: [VerseEng] = []
        var tvd: [VerseEng] = []
        // secondary language
        if let jsonData = loadJSONFile(fileName: getSecondaryFileName()) {
            let decoder = JSONDecoder()

            do {
                engBOM = try decoder.decode(EnglishBOM.self, from: jsonData)
                // loop over the list and get the secondary language info
                if bookIndex == 0 {
                    for locBook in engBOM.books {
                        if correctBook(bookName: locBook.book) {
                            break
                        }
                        bookIndex += 1
                    }
                }

                let chapterIndex = currentChapter
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
                let chapterIndex = currentChapter
               
                tvd = tglBOM.books[bookIndex].chapters[chapterIndex - 1].verses

            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        let count = evd.count

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
                ScrollView {
                    ForEach($verseData, id: \.self.verse) { $verse in
                        VStack {
                            HStack {
                                VStack {
                                    Text("\(verse.verse)")
                                        .font(
                                            .custom("Inder-Regular", size: 18)
                                        )
                                        .frame(alignment: .bottomLeading)
                                        .foregroundStyle(.blue)
                                    Spacer()
                                }.frame(width: 30)
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
                            .containerRelativeFrame(.horizontal) { length, axis in
                                return length * 0.8
                            }
                            .padding(2)

                        }
                        .background(Color.clear)
                    }
                    .frame(width: 500)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
                .padding(.top, 30)
                .containerRelativeFrame(.horizontal) { length, axis in
                    return length * 0.9
                }
                .containerRelativeFrame(.vertical) { length, axis in
                    return length * 0.95
                }
                Spacer()
                HStack {
                    Button {
                        if currentChapter - 1 > 0 {
                            currentChapter -= 1
                        } else {
                            bookIndex -= 1
                            currentChapter = getNewCurrentChapter()
                            currentBook = getNewCurrentBook()
                            totalChapters = getNewCurrentChapter()
                        }
                        
                        getBOMData()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.custom("Poppins-Regular", size: 30))
                            .foregroundStyle(.black)
                            .padding(8)
                            .opacity(bookIndex == 0 && currentChapter == 1 ? 0.3 : 1)
                    }
                    .frame(width: 60)
                    .opacity(bookIndex == 0 && currentChapter == 1 ? 0.3 : 1)
                    .cornerRadius(10)
                    .background(
                        // --- Top Layer: The button itself ---
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.chapterBorder)
                            .overlay(
                                // Add the thin black border
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(bookIndex == 0 && currentChapter == 1 ? .gray : .mint.opacity(0.4), lineWidth: 1)
                            )
                    )
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(bookIndex == 0 && currentChapter == 1 ? .gray: .mint)
                        }
                        // The magic offsets:
                        .offset(x: 0, y: 2)  // Slightly right, heavily down
                        .scaleEffect(x: 0.99, y: 1.0)
                    )
                    .disabled(bookIndex == 0 && currentChapter == 1)
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
                    .cornerRadius(10)
                    .background(
                        // --- Top Layer: The button itself ---
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.chapterBorder)
                            .overlay(
                                // Add the thin black border
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.blue, lineWidth: 1)
                            )
                    )
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.blue)
                        }
                        // The magic offsets:
                        .offset(x: 0, y: 3)  // Slightly right, heavily down
                        .scaleEffect(x: 0.99, y: 1.0)
                    )
                    .onTapGesture {
                        showBooksList = true
                    }
                    .overlay(alignment: .top) {
                        if showBooksList {
                            VStack {
                                HStack {
                                    ScrollViewReader { scrollView in
                                        ScrollView {
                                            VStack {
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
                                                                print(totalChapters)
                                                                currentChapter = 1
                                                                
                                                                getBOMData(resetBookIndex: true)
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
                                        VStack {
                                            ForEach(0..<totalChapters, id: \.self) { chapter in
                                                Text("\(chapter + 1)")
                                                    .font(.custom("Poppins-Regular", size: 30))
                                                    .transition(.move(edge: .bottom))
                                                    .foregroundStyle(.blue.opacity(0.6))
                                                    .onTapGesture {
                                                        withAnimation(.easeInOut(duration: 0.2))
                                                        {
                                                            currentChapter = chapter + 1
                                                            showBooksList = false
                                                            getBOMData(resetBookIndex: true)
                                                        }
                                                    }
                                                    .padding(.trailing, 25)
                                            }
                                        }
                                    }
                                    .frame(width: showBooksList ? 80 : 0, height: 440)
                                    .transition(.move(edge: .trailing))
                                }
                                .frame(height: 450)
                            }
                            .frame(width: 380, height: 460)
                            .background(.chapterBorder)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.4), radius: 1, x: 2, y: 3)
                            .offset(x: 0, y: -468)
                            //.alignmentGuide(.bottom) { d in d[.top] - 100 }
                            .transition(.scale(scale: 0.1))
                        }
                    }
                    Button {
                        if currentChapter + 1 <= totalChapters {
                            currentChapter += 1
                        } else {
                            bookIndex += 1
                            currentChapter = 1
                            currentBook = getNewCurrentBook()
                            totalChapters = getNewCurrentChapter()
                        }
                        
                        getBOMData()
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.custom("Poppins-Regular", size: 30))
                            .foregroundStyle(.black)
                            .padding(8)
                            .opacity(bookIndex == 14 && currentChapter == 10 ? 0.3 : 1)
                    }
                    .frame(width: 60)
                    .disabled(bookIndex == 14 && currentChapter == 10)
                    .opacity(bookIndex == 14 && currentChapter == 10 ? 0.3 : 1)
                    .cornerRadius(10)
                    .background(
                        // --- Top Layer: The button itself ---
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.chapterBorder)
                            .overlay(
                                // Add the thin black border
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(bookIndex == 14 && currentChapter == 10 ? .gray : .mint.opacity(0.4), lineWidth: 1)
                            )
                    )
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(bookIndex == 14 && currentChapter == 10 ? .gray : .mint)
                        }
                        // The magic offsets:
                        .offset(x: 0, y: 2)  // Slightly right, heavily down
                        .scaleEffect(x: 0.99, y: 1.0)
                    )
                }
                .frame(width: 370)
            }
            .containerRelativeFrame(.horizontal) { length, axis in
                return length * 0.8
            }
            .containerRelativeFrame(.vertical) { length, axis in
                return length * 0.978
            }
                .padding(.top, 30)
                .onTapGesture {
                    showBooksList = false
                }
                .toolbar {
                    if !showLanguages {
                        ToolbarItem(placement: .topBarTrailing) {  // or .navigationBarLeading
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
                    // ... (Empty placeholder if needed)
                }
                .frame(
                    width: showLanguages ? 300 : 0,
                    height: showLanguages ? 150 : 0
                )
                .background(.mint)
                .cornerRadius(12)
                .offset(x: showLanguages ? 0 : 0, y: showLanguages ? 0 : 0)

                VStack {
                    if showLanguages {
                        VStack {
                            HStack(spacing: 20) {
                                // MARK: Primary Language
                                VStack {
                                    Text("Primary Language")
                                        .font(.custom("Poppins-Regular", size: 13))
                                        .foregroundStyle(.white)

                                    Button {
                                        showPrimaryLangOptions.toggle()
                                    } label: {
                                        Text(tempPLang)
                                            .font(.custom("Poppins-Regular", size: 13))
                                            .foregroundStyle(.black)
                                    }
                                    .frame(width: 100, height: 40)
                                    .background(.mint.opacity(0.2))
                                    .background(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.mint, lineWidth: 1)
                                    )
                                    // MARK: Primary Dropdown Overlay
                                    .overlay(alignment: .topLeading) {
                                        if showPrimaryLangOptions {
                                            VStack(spacing: 0) {
                                                ForEach(["English", "Spanish", "Tagalog", "Cebuano"], id: \.self) { lang in
                                                    Text(lang)
                                                        .font(.custom("Poppins-Regular", size: 16))
                                                        .frame(height: 30)
                                                        .frame(maxWidth: .infinity)
                                                        .foregroundStyle(.black)
                                                        .contentShape(Rectangle())
                                                        .onTapGesture {
                                                            tempPLang = lang
                                                            showPrimaryLangOptions = false
                                                        }
                                                }
                                            }
                                            .frame(width: 110, height: 150)
                                            .background(Color.white)
                                            .cornerRadius(8)
                                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                                            .offset(y: 45)  // Drops menu directly below the button
                                            .zIndex(100)    // High z-index keeps it on top of CANCEL/CHANGE
                                        }
                                    }
                                }

                                // MARK: Secondary Language
                                VStack {
                                    Text("Secondary Language")
                                        .font(.custom("Poppins-Regular", size: 13))
                                        .foregroundStyle(.white)

                                    Button {
                                        showSecondaryLangOptions.toggle()
                                    } label: {
                                        Text(tempSLang)
                                            .font(.custom("Poppins-Regular", size: 13))
                                            .foregroundStyle(.black)
                                    }
                                    .frame(width: 100, height: 40)
                                    .background(.mint.opacity(0.2))
                                    .background(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.mint, lineWidth: 1)
                                    )
                                    .overlay(alignment: .topLeading) {
                                        if showSecondaryLangOptions {
                                            VStack {
                                                Text("English")
                                                    .font(.custom("Poppins-Regular", size: 16))
                                                    .frame(height: 30)
                                                    .foregroundStyle(.black)
                                                    .onTapGesture {
                                                        tempSLang = "English"
                                                        showSecondaryLangOptions = false
                                                    }
                                                Text("Spanish")
                                                    .font(.custom("Poppins-Regular", size: 16))
                                                    .frame(height: 30)
                                                    .foregroundStyle(.black)
                                                    .onTapGesture {
                                                        tempSLang = "Spanish"
                                                        showSecondaryLangOptions = false
                                                    }
                                                Text("Tagalog")
                                                    .font(.custom("Poppins-Regular", size: 16))
                                                    .frame(height: 30)
                                                    .foregroundStyle(.black)
                                                    .onTapGesture {
                                                        tempSLang = "Tagalog"
                                                        showSecondaryLangOptions = false
                                                    }
                                                Text("Cebuano")
                                                    .font(.custom("Poppins-Regular", size: 16))
                                                    .frame(height: 30)
                                                    .foregroundStyle(.black)
                                                    .onTapGesture {
                                                        tempSLang = "Cebuano"
                                                        showSecondaryLangOptions = false
                                                    }
                                            }
                                            .frame(width: 110, height: 150)
                                            .background(Color.white)
                                            .cornerRadius(8)
                                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                                            .offset(y: 45)  // Drops menu directly below the button
                                            .zIndex(150)    // High z-index keeps it on top of CANCEL/CHANGE
                                        }
                                    }
                                }
                            }

                            // MARK: Action Buttons
                            HStack {
                                Spacer()
                                HStack {
                                    if !showSecondaryLangOptions {
                                        Button {
                                            withAnimation(.easeInOut(duration: 0.1)) {
                                                tempPLang = primaryLang
                                                tempSLang = secondaryLang
                                                showLanguages = false
                                                showSecondaryLangOptions = false
                                                showPrimaryLangOptions = false
                                            }
                                        } label: {
                                            Text("CANCEL")
                                                .font(.custom("Poppins-Regular", size: 12))
                                                .foregroundStyle(.brown)
                                        }
                                        .frame(width: 80, height: 30)
                                        
                                        Button {
                                            withAnimation(.easeInOut(duration: 0.1)) {
                                                primaryLang = tempPLang
                                                secondaryLang = tempSLang
                                                tempPLang = primaryLang
                                                tempSLang = secondaryLang
                                                showLanguages = false
                                                showSecondaryLangOptions = false
                                                showPrimaryLangOptions = false
                                                translateName()
                                                getBOMData()
                                            }
                                        } label: {
                                            Text("CHANGE")
                                                .font(.custom("Poppins-Regular", size: 12))
                                                .foregroundStyle(.blue)
                                        }
                                        .frame(width: 80, height: 30)
                                    }
                                }
                                .frame(height: 30)
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
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black).brightness(0.1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.mint, lineWidth: 0.2)
                        )
                )
                .offset(
                    x: showLanguages ? 0 : 150,
                    y: showLanguages ? -5 : -385
                )
                //.shadow(color: Color.black.opacity(0.5), radius: 2, x: 3, y: 4)
                .zIndex(1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Make the frame
        .background(.versesBackground)
        .ignoresSafeArea()
        .onAppear {
            getBOMData(resetBookIndex: true)
            showBooksList = false
            showLanguages = false
            showPrimaryLangOptions = false
            showSecondaryLangOptions = false
            tempPLang = primaryLang
            tempSLang = secondaryLang
        }

    }
    
    func translateBookName(standardBookName: String) -> String {
        var newName = ""

        if primaryLang == "Spanish" {
            newName = ENG_TO_ESP[standardBookName]!
        } else if primaryLang == "Tagalog" {
            newName = ENG_TO_TAG[standardBookName]!
        } else if primaryLang == "Cebuano" {
            newName = ENG_TO_CEB[standardBookName]!
        } else {
            newName = standardBookName
        }
        
        return newName
    }
    
    func getNewCurrentChapter() -> Int {
        if primaryLang == "English" {
            return BOM_BOOKS[bookIndex].chapterCount
        } else if primaryLang == "Spanish" {
            return BOM_BOOKS_SPANISH[bookIndex].chapterCount
        } else if primaryLang == "Cebuano" {
            return BOM_BOOKS_CEBUANO[bookIndex].chapterCount
        } else {
            return BOM_BOOKS_TAGALOG[bookIndex].chapterCount
        }
    }
    
    func getNewCurrentBook() -> String {
        if primaryLang == "English" {
            return BOM_BOOKS[bookIndex].name
        } else if primaryLang == "Spanish" {
            return BOM_BOOKS_SPANISH[bookIndex].name
        } else if primaryLang == "Cebuano" {
            return BOM_BOOKS_CEBUANO[bookIndex].name
        } else {
            return BOM_BOOKS_TAGALOG[bookIndex].name
        }
    }
}

#Preview {
    VersesView(
        primaryLang: .constant("Spanish"),
        secondaryLang: .constant("English"),
        currentBook: .constant("1 Nefi"),
        currentChapter: 1,
        totalChapters: .constant(4)
    )
}
