//
//  ConferenceTalkView.swift
//  DualScripture
//
//  Created by Michael Knight on 10/10/26.
//

import SwiftUI

struct ConferenceTalkView: View {
    @Binding var primaryLang: String
    @Binding var secondaryLang: String
    
    @Binding var pConferenceTalk: ConferenceTalkListItem
    @Binding var sConferenceTalk: ConferenceTalkListItem
    var getConferenceTalksList: () -> Void

    @State private var talkParagraphs: [DualLanguageConferenceTalkParagraphs] = []
    @State private var dualLanguageTalkMetaData: DualLanguageConferenceTalk = mockConferenceTalk
    @State var showLanguages: Bool = false
    @State var showSecondaryLangOptions: Bool = false
    @State var showPrimaryLangOptions: Bool = false
    @State private var tempPLang: String = ""
    @State private var tempSLang: String = ""
    
    func formatData() -> Void {
        
        talkParagraphs = []
        
        for (index, p) in pConferenceTalk.paragraphs.enumerated() {
            talkParagraphs.append(DualLanguageConferenceTalkParagraphs(knownLangVerse: sConferenceTalk.paragraphs[index], targetLangVerse: p, showTargetLang: true))
        }
        
        dualLanguageTalkMetaData.pTitle = pConferenceTalk.title
        dualLanguageTalkMetaData.pAuthor = pConferenceTalk.author
        dualLanguageTalkMetaData.pCalling = pConferenceTalk.calling
        dualLanguageTalkMetaData.pSubject = pConferenceTalk.subject

        dualLanguageTalkMetaData.sTitle = sConferenceTalk.title
        dualLanguageTalkMetaData.sAuthor = sConferenceTalk.author
        dualLanguageTalkMetaData.sCalling = sConferenceTalk.calling
        dualLanguageTalkMetaData.sSubject = sConferenceTalk.subject

        showPrimaryLangOptions = false
        showSecondaryLangOptions = false
        tempPLang = primaryLang
        tempSLang = secondaryLang
        
        print(dualLanguageTalkMetaData)
    }
    
    var body: some View {
        ZStack {
            // 1. Background fills edge-to-edge safely
            Rectangle()
                .fill(.versesBackground)
                .ignoresSafeArea()
            
            // 2. Wrap the WHOLE page in a ScrollView
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // --- HEADER SECTION ---
                    HStack {
                        HStack {
                            if !dualLanguageTalkMetaData.showTargetLangTitle {
                                Divider()
                                    .frame(width: 5)
                                    .overlay(.black)
                                    .cornerRadius(5)
                                    .padding(.leading, 50)
                            }
                            Text(dualLanguageTalkMetaData.showTargetLangTitle ? dualLanguageTalkMetaData.pTitle : dualLanguageTalkMetaData.sTitle)
                                .foregroundStyle(.mint)
                                .font(.custom("Poppins-Regular", size: 35))
                                .padding(.leading, dualLanguageTalkMetaData.showTargetLangTitle ? 50 : 0)
                                .onTapGesture {
                                    dualLanguageTalkMetaData.showTargetLangTitle.toggle()
                                }
                        }
                        Spacer()
                    }
                    .padding(.top, 20) // Breathing room at the very top of the scroll
                    
                    HStack {
                        HStack {
                            if !dualLanguageTalkMetaData.showTargetLangAuthor {
                                VStack {
                                    Spacer()
                                    Divider()
                                        .frame(width: 5, height: 20)
                                        .overlay(.mint)
                                        .cornerRadius(5)
                                        .padding(.leading, 50)
                                }
                            }
                            Text(dualLanguageTalkMetaData.showTargetLangAuthor ? dualLanguageTalkMetaData.pAuthor : dualLanguageTalkMetaData.sAuthor)
                                .foregroundStyle(Color.gray)
                                .font(.custom("Poppins-Bold", size: 15))
                                .padding(.top, 20)
                                .padding(.leading, dualLanguageTalkMetaData.showTargetLangAuthor ? 50 : 0)
                                .onTapGesture {
                                    dualLanguageTalkMetaData.showTargetLangAuthor.toggle()
                                }
                        }
                        Spacer()
                    }
                    
                    HStack {
                        HStack {
                            if !dualLanguageTalkMetaData.showTargetLangCalling {
                                VStack {
                                    Spacer()
                                    Divider()
                                        .frame(width: 5, height: 50)
                                        .overlay(.mint)
                                        .cornerRadius(5)
                                        .padding(.leading, 50)
                                }
                            }
                            Text(dualLanguageTalkMetaData.showTargetLangCalling ? dualLanguageTalkMetaData.pCalling : dualLanguageTalkMetaData.sCalling)
                                .foregroundStyle(Color.gray)
                                .font(.custom("Poppins-BoldItalic", size: 15))
                                .padding(.leading, dualLanguageTalkMetaData.showTargetLangCalling ? 50 : 0)
                                .onTapGesture {
                                    dualLanguageTalkMetaData.showTargetLangCalling.toggle()
                                }
                        }
                        Spacer()
                    }
                    
                    HStack {
                        HStack {
                            if !dualLanguageTalkMetaData.showTargetLangSubject {
                                VStack {
                                    Spacer()
                                    Divider()
                                        .frame(width: 5, height: 70)
                                        .overlay(.mint)
                                        .cornerRadius(5)
                                        .padding(.leading, 50)
                                }
                            }
                            Text(dualLanguageTalkMetaData.showTargetLangSubject ? dualLanguageTalkMetaData.pSubject : dualLanguageTalkMetaData.sSubject)                                .foregroundStyle(Color.gray)
                                .font(.custom("Poppins-Light", size: 15))
                                .padding(.top, 30)
                                .padding(.leading, dualLanguageTalkMetaData.showTargetLangSubject ? 50 : 0)
                                .onTapGesture {
                                    dualLanguageTalkMetaData.showTargetLangSubject.toggle()
                                }
                        }
                        Spacer()
                    }
                    .padding(.bottom, 30) // Extra space before paragraphs start
                    
                    // --- PARAGRAPHS SECTION ---
                    // Replaced 'List' with 'LazyVStack' + 'ForEach'
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(Array($talkParagraphs.enumerated()), id: \.offset) { index, $p in
                            HStack(alignment: .top) {
                                VStack {
                                    Text("\(index + 1)")
                                        .font(.custom("Poppins-Bold", size: 18))
                                        .foregroundStyle(.blue)
                                    Spacer()
                                }
                                .frame(width: 30) // Gives the paragraph numbers a clean, consistent width
                                
//                                Text(p.showTargetLang ? p.targetLangVerse : p.knownLangVerse)
//                                    .font(.custom("Poppins-Regular", size: 15))
//                                    .foregroundStyle(.gray)
                                HStack {
                                    if !p.showTargetLang {
                                        Divider()
                                            .frame(width: 5)
                                            .overlay(.mint)
                                            .cornerRadius(5)
                                    }
                                    Text(
                                        p.showTargetLang
                                        ? p.targetLangVerse
                                        : p.knownLangVerse
                                    )
                                    .font(.custom("Poppins-Regular", size: 18))
                                    .foregroundStyle(.gray)
                                    .onTapGesture {
                                        withAnimation(
                                            .spring(.bouncy(duration: 0.3))
                                        ) {
                                            p.showTargetLang.toggle()
                                            
                                        }
                                        
                                        //showBooksList = false
                                        
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .padding(.top, 40)
                }
                .padding(.bottom, 40) // Bottom padding so text doesn't cut off at screen edge
            }
            .toolbar {
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
                                                getConferenceTalksList()
                                                formatData()
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
        .onAppear {
            // convert the paragraphs to the proprer format
            formatData()
        }
    }
}

#Preview {
    ConferenceTalkView(primaryLang: .constant("Tagalog"), secondaryLang: .constant("English"),
                       pConferenceTalk: .constant(ConferenceTalkListItem(itemType: "Talk", title: "Pangwakas na Mensahe", author: "Ni Pangulong Dallin H. Oaks", calling: "Pangulo ng Ang Simbahan ni Jesucristo ng mga Banal sa mga Huling Araw", subject: "Habang inaabangan natin ang hinaharap, wini-welcome natin ang mundo, nang personal o virtual, sa Pagdiriwang sa Salt Lake Temple.", paragraphs: [
                        "Aking minahamahal na mga kapatid, ang dakilang mga mensahe sa kumperensiyang ito at ang Espiritu ng Panginoon ay nagbigay-inspirasyon sa ating lahat na ituon ang ating pagsamba, ipokus ang ating pag-aaral, at pag-isahin ang ating mga patotoo sa mga turo ng Panginoong Jesucristo at sa plano ng Kanyang Ama para sa ating walang-hanggang pag-unlad at kagalakan.",
                        "Kapag nailathala na ang mga mensahe sa kumperensiyang ito, inaanyayahan namin ang lahat na pag-aralan at pagnilayan ang mga ito nang may panalangin at kumilos nang may pananampalataya ayon sa mga alituntuning ipinapaliwanag ng mga ito. Nangako ang Panginoon, 'Siya na tumatanggap ay bibigyan ko pa ng karagdagan.'",
                        "Habang inaabangan natin ang hinaharap, wini-welcome natin ang mundo, nang personal o virtual, sa Pagdiriwang sa Salt Lake Temple. Sa Abril-05, 2027, bubuksan sa publiko ang mga pinto ng templo, ang unang ganitong pagbubukas simula noong 1893, 134 na taon ang nakararaan.",
                        "Samahan kami sa TempleSquare.org o sa pamamagitan ng Temple Square app upang alamin ang iba pa.",
                        "Kasunod ng sesyong ito ng pangkalahatang kumperensiya, ang unang episode ng magandang video series na Ilaan ay unang ipalalabas sa buong mundo sa iba't ibang wika. Marami pang darating sa mga susunod na buwan, kabilang ang isang virtual tour ng Salt Lake Temple.",
                        "Sa ating pagpapatuloy ngayon, binabasbasan namin kayo at ang inyong mga pamilya ng mga pagpapala ng Panginoon, na mga pagpapala ng kapayapaan at kasiyahan. At binabasbasan namin ang iyong paglilingkod sa Panginoong Jesucristo sa mga panahong ito ng pagsubok.",
                        "Magtatapos ako sa aking patotoo. Ito ang ipinanumbalik na ebanghelyo ni Jesucristo sa Kanyang Simbahan ni Jesucristo ng mga Banal sa mga Huling Araw. Dito mahahanap ang katotohanan-katotohanan tungkol sa mga turo ng Panginoon at katotohanan tungkol sa landas ng tipan na patungo sa ating tadhana, ang tadhanang hangad ng ating Ama sa Langit. Pinatototohanan ko ito sa inyo sa pangalan ni Jesucristo, amen."
                    ])),
                       sConferenceTalk: .constant(ConferenceTalkListItem(itemType: "Talk", title: "Prophets, Seers, and Revelators", author: "By President Dallin H. Oaks", calling: "President of The Church of Jesus Christ of Latter-day Saints", subject: "As we look forward, we are welcoming the world, in person or virtually, to the Salt Lake Temple Celebration.", paragraphs: [
                        "My dear brothers and sisters, the great messages of this conference and the Spirit of the Lord have inspired all of us to concentrate our worship, focus our learning, and unite our testimonies on the teachings of the Lord Jesus Christ and His Father's plan for our eternal increase and joy.",
                        "As the talks of this conference are published, we invite all to study and ponder them prayerfully and to act in faith on the principles they explain. The Lord has promised, 'Unto him that receiveth I will give more.'",
                        "As we look forward, we are welcoming the world, in person or virtually, to the Salt Lake Temple Celebration. On April 05, 2027, the temple doors will open to the public - the first such opening since 1893, 134 years ago.",
                        "Join us at TempleSquare.org or through the Temple Square app to learn more.",
                        "Following this session of general conference, the first episode of a dynamic video series, Dedicate, will premiere worldwide in multiple languages. More will come in the months ahead, including a virtual tour of the Salt Lake Temple.",
                        "As we now go forward, we invoke the blessings of the Lord on you and your families, blessings of peace and contentment. And we bless your service of the Lord Jesus Christ in these challenging times.",
                        "I close with my testimony. This is the restored gospel of Jesus Christ in His Church of Jesus Christ of Latter-day Saints. Truth is to be found here - truth about the teachings of the Lord and truth about the covenant path that will lead us to our destiny, the destiny desired by our Heavenly Father. Of all this I testify to you in the name of Jesus Christ, amen."
                    ])), getConferenceTalksList: {}
                       
    )
}
