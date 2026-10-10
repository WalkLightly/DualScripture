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
    
    let conferenceTalk: ConferenceTalkListItem
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
                        Text(conferenceTalk.title)
                            .foregroundStyle(Color.gray)
                            .font(.custom("Poppins-Regular", size: 35))
                            .padding(.leading, 50)
                        Spacer()
                    }
                    .padding(.top, 20) // Breathing room at the very top of the scroll
                    
                    HStack {
                        Text(conferenceTalk.author)
                            .foregroundStyle(Color.gray)
                            .font(.custom("Poppins-Bold", size: 15))
                            .padding(.top, 20)
                            .padding(.leading, 50)
                        Spacer()
                    }
                    
                    HStack {
                        Text(conferenceTalk.calling)
                            .foregroundStyle(Color.gray)
                            .font(.custom("Poppins-BoldItalic", size: 15))
                            .padding(.leading, 50)
                        Spacer()
                    }
                    
                    HStack {
                        Text(conferenceTalk.subject)
                            .foregroundStyle(Color.gray)
                            .font(.custom("Poppins-Light", size: 15))
                            .padding(.leading, 50)
                            .padding(.top, 30)
                        Spacer()
                    }
                    .padding(.bottom, 30) // Extra space before paragraphs start
                    
                    // --- PARAGRAPHS SECTION ---
                    // Replaced 'List' with 'LazyVStack' + 'ForEach'
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(Array(conferenceTalk.paragraphs.enumerated()), id: \.offset) { index, p in
                            HStack(alignment: .top) {
                                VStack {
                                    Text("\(index + 1)")
                                        .font(.custom("Poppins-Bold", size: 18))
                                        .foregroundStyle(.blue)
                                    Spacer()
                                }
                                .frame(width: 30) // Gives the paragraph numbers a clean, consistent width
                                
                                Text(p)
                                    .font(.custom("Poppins-Regular", size: 15))
                                    .foregroundStyle(.gray)
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .padding(.top, 40)
                }
                .padding(.bottom, 40) // Bottom padding so text doesn't cut off at screen edge
            }
        }
        .onAppear {
            //     getBOMData(resetBookIndex: true)
            //     showBooksList = false
            //     showLanguages = false
            //     showPrimaryLangOptions = false
            //     showSecondaryLangOptions = false
            //     tempPLang = primaryLang
            //     tempSLang = secondaryLang
        }
    }
    
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(.versesBackground)
//                .ignoresSafeArea()
//            VStack {
//                HStack {
//                    Text(conferenceTalk.title)
//                        .foregroundStyle(Color.gray)
//                        .font(.custom("Poppins-Regular", size: 35))
//                        .padding(.leading, 50)
//                    Spacer()
//                }
//                HStack {
//                    Text(conferenceTalk.author)
//                        .foregroundStyle(Color.gray)
//                        .font(.custom("Poppins-Bold", size: 15))
//                        .padding(.top, 10)
//                        .padding(.leading, 50)
//                    Spacer()
//                }
//                HStack {
//                    Text(conferenceTalk.calling)
//                        .foregroundStyle(Color.gray)
//                        .font(.custom("Poppins-BoldItalic", size: 15))
//                        .padding(.leading, 50)
//                    Spacer()
//                }
//                HStack {
//                    Text(conferenceTalk.subject)
//                        .foregroundStyle(Color.gray)
//                        .font(.custom("Poppins-Light", size: 15))
//                        .padding(.leading, 50)
//                        .padding(.top, 15)
//                    Spacer()
//                }
//                
//                List(conferenceTalk.paragraphs.enumerated(), id: \.offset) { index, p in
//                    HStack {
//                        VStack {
//                            Text("\(index + 1)")
//                                .font(.custom("Poppins-Bold", size: 18))
//                                .foregroundStyle(.blue)
//                            Spacer()
//                        }
//                        
//                        Text(p)
//                            .padding(.leading, 20)
//                            .font(.custom("Poppins-Regular", size: 15))
//                            .foregroundStyle(.gray)
//                    }
//                    .listRowSeparator(.hidden)
//                    .listRowBackground(Color.clear)
//                    .listRowInsets(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
//                }
//                .listStyle(.plain)
//                .scrollContentBackground(.hidden)
//                
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Make the frame
//        .background(.versesBackground)
//        .onAppear {
//            //        getBOMData(resetBookIndex: true)
//            //        showBooksList = false
//            //        showLanguages = false
//            //        showPrimaryLangOptions = false
//            //        showSecondaryLangOptions = false
//            //        tempPLang = primaryLang
//            //        tempSLang = secondaryLang
//        }
//        
//    }
}

#Preview {
    ConferenceTalkView(primaryLang: .constant("Tagalog"), secondaryLang: .constant("English"),
                       conferenceTalk: ConferenceTalkListItem(itemType: "Talk", title: "Prophets, Seers, and Revelators", author: "By President Dallin H. Oaks", calling: "President of The Church of Jesus Christ of Latter-day Saints", subject: "As we look forward, we are welcoming the world, in person or virtually, to the Salt Lake Temple Celebration.", paragraphs: [
                        "My dear brothers and sisters, the great messages of this conference and the Spirit of the Lord have inspired all of us to concentrate our worship, focus our learning, and unite our testimonies on the teachings of the Lord Jesus Christ and His Father's plan for our eternal increase and joy.",
                        "As the talks of this conference are published, we invite all to study and ponder them prayerfully and to act in faith on the principles they explain. The Lord has promised, 'Unto him that receiveth I will give more.'",
                        "As we look forward, we are welcoming the world, in person or virtually, to the Salt Lake Temple Celebration. On April 05, 2027, the temple doors will open to the public - the first such opening since 1893, 134 years ago.",
                        "Join us at TempleSquare.org or through the Temple Square app to learn more.",
                        "Following this session of general conference, the first episode of a dynamic video series, Dedicate, will premiere worldwide in multiple languages. More will come in the months ahead, including a virtual tour of the Salt Lake Temple.",
                        "As we now go forward, we invoke the blessings of the Lord on you and your families, blessings of peace and contentment. And we bless your service of the Lord Jesus Christ in these challenging times.",
                        "I close with my testimony. This is the restored gospel of Jesus Christ in His Church of Jesus Christ of Latter-day Saints. Truth is to be found here - truth about the teachings of the Lord and truth about the covenant path that will lead us to our destiny, the destiny desired by our Heavenly Father. Of all this I testify to you in the name of Jesus Christ, amen."
                    ])
    )
}
