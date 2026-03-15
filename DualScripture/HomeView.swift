//
//  ContentView.swift
//  DualScripture
//
//  Created by Michael Knight on 1/14/26.
//

import SwiftUI
import Foundation
import SwiftSoup



struct HomeView: View {
    var languages: [String] = ["Tagalog", "English", "Spanish", "Cebuano"]
    @State var primaryLang: String = "Tagalog"
    @State var secondaryLang: String = "English"
    
    @State var showPrimaryLangOptions: Bool = false
    @State var showSecondaryLangOptions: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.mainBackground.ignoresSafeArea(.all).opacity(0.6)
                VStack {
                    HStack {
                        NavigationLink(destination: BOMBooksListView(primaryLang: primaryLang, secondaryLang: secondaryLang)) {
                            VStack {
                                VStack {
                                    Rectangle()
                                        .stroke(.gold, lineWidth: 1)
                                        .frame(width: 80, height: 1)
                                    Text("THE")
                                        .font(.custom("Poppins-Regular", size: 13))
                                        .foregroundStyle(.gold)
                                        .padding(.top, -8)
                                    Text("BOOK")
                                        .font(.custom("Poppins-Regular", size: 13))
                                        .foregroundStyle(.gold)
                                        .padding(.top, -16)
                                    Text("OF")
                                        .font(.custom("Poppins-Regular", size: 13))
                                        .foregroundStyle(.gold)
                                        .padding(.top, -16)
                                    Text("MORMON")
                                        .font(.custom("Poppins-Regular", size: 13))
                                        .foregroundStyle(.gold)
                                        .padding(.top, -16)
                                    
                                    Rectangle()
                                        .stroke(.gold, lineWidth: 1)
                                        .frame(width: 80, height: 1)
                                        .padding(.top, -10)
                                }
                                .padding(.top, -40)
                            }
                            .frame(width: 100, height: 150)
                            .background(.bomBlue)
                            .cornerRadius(5)
                            
                        }
                        VStack {
                            VStack {
                                
                                Rectangle()
                                    .stroke(.gold, lineWidth: 1)
                                    .frame(width: 80, height: 1)
                                Text("PEARL OF")
                                    .font(.custom("Poppins-Regular", size: 13))
                                    .foregroundStyle(.gold)
                                    .padding(.top, -8)
                                Text("GREAT PRICE")
                                    .font(.custom("Poppins-Regular", size: 13))
                                    .foregroundStyle(.gold)
                                    .padding(.top, -16)
                                
                                Rectangle()
                                    .stroke(.gold, lineWidth: 1)
                                    .frame(width: 80, height: 1)
                                    .padding(.top, -10)
                            }
                            .padding(.top, -55)
                        }
                        .frame(width: 100, height: 150)
                        .background(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1) // 2. Apply border to same shape
                        )
                        .cornerRadius(5)
                        VStack {
                            VStack {
                                
                                Rectangle()
                                    .stroke(.gold, lineWidth: 1)
                                    .frame(width: 80, height: 1)
                                Text("DOCTRINE")
                                    .font(.custom("Poppins-Regular", size: 13))
                                    .foregroundStyle(.gold)
                                    .padding(.top, -8)
                                Text("AND")
                                    .font(.custom("Poppins-Regular", size: 13))
                                    .foregroundStyle(.gold)
                                    .padding(.top, -16)
                                Text("COVENANTS")
                                    .font(.custom("Poppins-Regular", size: 13))
                                    .foregroundStyle(.gold)
                                    .padding(.top, -16)
                                
                                Rectangle()
                                    .stroke(.gold, lineWidth: 1)
                                    .frame(width: 80, height: 1)
                                    .padding(.top, -10)
                            }
                            .padding(.top, -53)
                        }
                        .frame(width: 100, height: 150)
                        .background(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1) // 2. Apply border to same shape
                        )
                        .cornerRadius(5)
                    }
                    .padding(.top, 50)
                    ZStack {
                        
                        VStack {
                            
                        }
                        .frame(width: 349, height: 30)
                        .background(.blue)
                        .cornerRadius(12)
                        .offset(y: 28)
                        HStack(spacing: 50) {
                            VStack {
                                Text("Primary Language")
                                    .font(.custom("Poppins-Regular", size: 13))
                                    .foregroundStyle(.black)
                                Button {
                                    showPrimaryLangOptions = true
                                } label: {
                                    Text(primaryLang)
                                        .font(.custom("Poppins-Regular", size: 13))
                                        .foregroundStyle(.black)
                                }
                                .frame(width: 100, height: 40)
                                .background(.mint.opacity(0.2))
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.mint, lineWidth: 1) // 2. Apply border to same shape
                                )
                            }
                            
                            VStack {
                                Text("Secondary Language")
                                    .font(.custom("Poppins-Regular", size: 13))
                                    .foregroundStyle(.black)
                                Button {
                                    showSecondaryLangOptions = true
                                } label: {
                                    Text(secondaryLang)
                                        .font(.custom("Poppins-Regular", size: 13))
                                        .foregroundStyle(.black)
                                }
                                .frame(width: 100, height: 40)
                                .background(.mint.opacity(0.2))
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.mint, lineWidth: 1) // 2. Apply border to same shape
                                )
                            }
                        }
                        .frame(width: 350, height: 80)
                        .background(LinearGradient(gradient: Gradient(colors: [.versesBackground, .chapterBorder, .chapterBorder, .chapterBorder, .chapterBorder]),startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                    }
                    .frame(width: 350, height: 90)
                }
                if showPrimaryLangOptions {
                    VStack {
                        Text("English")
                            .font(.custom("Poppins-Regular", size: 20))
                            .frame(height: 30)
                            .foregroundStyle(.black)
                            .onTapGesture {
                                primaryLang = "English"
                                showPrimaryLangOptions = false
                            }
                        Text("Spanish")
                            .font(.custom("Poppins-Regular", size: 20))
                            .frame(height: 30)
                            .foregroundStyle(.black)
                            .onTapGesture {
                                primaryLang = "Spanish"
                                showPrimaryLangOptions = false
                            }
                        Text("Tagalog")
                            .font(.custom("Poppins-Regular", size: 20))
                            .frame(height: 30)
                            .foregroundStyle(.black)
                            .onTapGesture {
                                primaryLang = "Tagalog"
                                showPrimaryLangOptions = false
                            }
                        Text("Cebuano")
                            .font(.custom("Poppins-Regular", size: 20))
                            .frame(height: 30)
                            .foregroundStyle(.black)
                            .onTapGesture {
                                primaryLang = "Cebuano"
                                showPrimaryLangOptions = false
                            }
                    }
                    .frame(width: 100, height: 170)
                    .background(.white)
                    .offset(x: -93, y: 12)
                }
                if showSecondaryLangOptions {
                    VStack {
                        Text("English")
                            .font(.custom("Poppins-Regular", size: 20))
                            .frame(height: 30)
                            .foregroundStyle(.black)
                            .onTapGesture {
                                secondaryLang = "English"
                                showSecondaryLangOptions = false
                            }
                        Text("Spanish")
                            .font(.custom("Poppins-Regular", size: 20))
                            .frame(height: 30)
                            .foregroundStyle(.black)
                            .onTapGesture {
                                secondaryLang = "Spanish"
                                showSecondaryLangOptions = false
                            }
                        Text("Tagalog")
                            .font(.custom("Poppins-Regular", size: 20))
                            .frame(height: 30)
                            .foregroundStyle(.black)
                            .onTapGesture {
                                secondaryLang = "Tagalog"
                                showSecondaryLangOptions = false
                            }
                        Text("Cebuano")
                            .font(.custom("Poppins-Regular", size: 20))
                            .frame(height: 30)
                            .foregroundStyle(.black)
                            .onTapGesture {
                                secondaryLang = "Cebuano"
                                showSecondaryLangOptions = false
                            }
                    }
                    .frame(width: 100, height: 170)
                    .background(.white)
                    .offset(x: 87, y: 12)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                showPrimaryLangOptions = false
                showSecondaryLangOptions = false
            }
        }
        .onAppear() {
            showPrimaryLangOptions = false
            showSecondaryLangOptions = false
        }
    }
}

#Preview {
    HomeView()
}
