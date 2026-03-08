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
    var body: some View {
            NavigationStack {
                ZStack {
                    Color.black.ignoresSafeArea(.all)
                    HStack {
                        NavigationLink(destination: BOMChapterListView()) {
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
                        .background(.black)
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
                        .background(.black)
                        .frame(width: 100, height: 150)
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
                        .cornerRadius(5)
                        
                    }
                    .background(.black)
                    .padding(.top, 50)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
        }
    }
}

#Preview {
    HomeView()
}
