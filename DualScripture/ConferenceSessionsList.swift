//
//  ConferenceSessionsList.swift
//  DualScripture
//
//  Created by Michael Knight on 10/9/26.
//

import SwiftUI
// here i will update the month and year array
struct ConferenceSessionsList: View {
    let sessions: [String] = [
        "Oct-2026",
    ]
    
    let sessionsImgMap: [String: String] = [
        "Oct-2026": "GenConIcon",
        "Apr-2026": "Apr2026",
        "Oct-2025": "Oct2025",
        "Apr-2025": "Apr2025"
    ]
    
    @Binding var primaryLang: String
    @Binding var secondaryLang: String
    @State var chosenMonth: String = ""
    
    let conferenceName: [String: String] = [
        "English": "General Conference",
        "Tagalog": "Pangkalahatang Kumperensya",
        "Cebuano": "Kinatibuk-ang Komperensiya",
        "Spanish": "Conferencia General"
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Text(conferenceName[primaryLang] ?? "General Conference")
                        .foregroundStyle(Color.black)
                        .font(.custom("Poppins-Regular", size: 15))
                        .padding(.horizontal, 15)
                }
                .frame(height: 45)
                .background(.blue)
                .cornerRadius(12)
                .offset(x: 0, y: 5)
                VStack {
                    Text(conferenceName[primaryLang] ?? "General Conference")
                        .foregroundStyle(Color.black)
                        .font(.custom("Poppins-Regular", size: 15))
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
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0..<sessions.count, id: \.self) { sessionsIndex in
                                NavigationLink(destination: SessionTalksList(primaryLang: $primaryLang, secondaryLang: $secondaryLang, chosenMonth: sessions[sessionsIndex])) {
                                    VStack {
                                        VStack{
                                            
                                        }
                                        .frame(width: 100, height: 120)
                                        .background {
                                            Image(sessionsImgMap[sessions[sessionsIndex]] ?? "GenConIcon")
                                                .resizable()
                                                .scaledToFill()
                                                .ignoresSafeArea()
                                        }
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color.chapterBorder, lineWidth: 1)  // 2. Apply border to same shape
                                        )
                                        .cornerRadius(10)
                                        Text(sessions[sessionsIndex])
                                            .font(.custom("Poppins-Regular", size: 15))
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                        
                    }
                }
                .containerRelativeFrame(.horizontal) { length, axis in
                    return length * 0.9
                }
                .containerRelativeFrame(.vertical) { length, axis in
                    return length * 0.9
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 30)
    }
}

#Preview {
    ConferenceSessionsList(primaryLang: .constant("Spanish"), secondaryLang: .constant("English"))
}
