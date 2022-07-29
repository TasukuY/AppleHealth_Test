//
//  ContentView.swift
//  AppleHealth_Test
//
//  Created by Tasuku Yamamoto on 7/29/22.
//

import SwiftUI

struct ContentView: View {
    
    private var healthStore = HealthStore()
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: items, spacing: 2) {
                    ForEach(HealthCategory.allCategories()) { category in
                        NavigationLink {
                            DetailView(healthCategory: category, healthStore: healthStore)
                        } label: {
                            VStack{
                                Text(category.image)
                                    .frame(width: 50, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.red.opacity(0.2)))
                                Text(category.name)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.2)))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("My Health Info")
        }
        .onAppear {
            healthStore.requestAuthorization { success in
                print("Auth Succsess? \(success)")
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


