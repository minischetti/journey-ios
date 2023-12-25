//
//  ContentView.swift
//  Journey
//
//  Created by Dominic Minischetti on 12/24/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        TabView {
                Text("Home")
                .tabItem {
                    Image(systemName: "house")
                }
                List {
                    Text("Lists")
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                }

            
                
                Form {
                    Section {
                        TextField("Title", text: .constant(""))
                        
                    }
                }
                .tabItem {
                    Image(systemName: "plus")
                }
        }

    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
