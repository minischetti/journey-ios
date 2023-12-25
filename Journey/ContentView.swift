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
                    ForEach(items) { item in
                        Text(item.title)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            modelContext.delete(items[index])
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listStyle(PlainListStyle())
                    .navigationTitle("Items")
#if iOS
                    .toolbar {

                            EditButton()

                    }
                    .environment(\.editMode, .constant(.active))
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: EditButton())
#endif
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                }
                FormSection()

        }

    }

    struct FormSection: View {
        @Environment(\.modelContext) private var modelContext
        @Query private var items: [Item]
        @State var title = ""
        @State var content = ""
        @State var dueDate = Date()
        @State var repeatInterval = 0
        @State var repeatUnit = RepeatUnit.day

        func save() {
            let item = Item(title: title, content: content, status: Status.pending, creationDate: Date(), dueDate: dueDate)
            modelContext.insert(item)
        }

        var body: some View {
                Form {
                    Section {
                        TextField("Title", text: $title)
                        TextField("Content", text: $content)
                        DatePicker("Due Date", selection: .constant(Date()))
                    }
                    Section {

                        // Repeat every {interval} {unit} until {end} or {count} times
                        Stepper(value: $repeatInterval) {
                            Text("Repeat every \(repeatInterval) \(repeatUnit.rawValue)(s)")
                        }
                        Picker("Unit", selection: $repeatUnit) {
                            Text("Day").tag(RepeatUnit.day)
                            Text("Week").tag(RepeatUnit.week)
                            Text("Month").tag(RepeatUnit.month)
                            Text("Year").tag(RepeatUnit.year)
                        }
                        DatePicker("End", selection: .constant(Date()))
                    }
                    Section {
                        Button("Save") {
                            save()
                        }
                    }
                }
                .tabItem {
                    Image(systemName: "plus")
                }
        }
    }



    var newItemForm: some View {
        Picker("Status", selection: .constant(0)) {
            Text("Pending").tag(0)
            Text("Working").tag(1)
            Text("Done").tag(2)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
