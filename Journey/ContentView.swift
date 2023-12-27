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
    @State private var isShowingSheet = false

    var body: some View {
        TabView {
//                Text("Home")
//                .tabItem {
//                    Image(systemName: "house")
//                }
            VStack {
                List {
                    ForEach(items) { item in
                        Text(item.title)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            modelContext.delete(items[index])
                        }
                    }
                }
                Button(action : {
                    isShowingSheet.toggle()
                }) {
                    Text("Add item")
                }
                .padding()
                .sheet(isPresented: $isShowingSheet) {
                    addListForm()
                }
                Spacer()
            }
            .tabItem {
                Image(systemName: "list.bullet")
            }

        }

    }

    struct addListForm: View {
        @Environment(\.modelContext) private var modelContext
        @Environment(\.dismiss) private var dismiss
        @Query private var items: [Item]
        @State var title = ""
        @State var content = ""
        @State var dueDate = Date()
        @State var repeatInterval = 0
        @State var repeatUnit = RepeatUnit.day
        @State private var isShowingSheet = false

        func save() {
            let item = Item(title: title, content: content, status: Status.pending, creationDate: Date(), dueDate: dueDate)
            modelContext.insert(item)
        }

        func reset() {
            title = ""
            content = ""
            dueDate = Date()
            repeatInterval = 0
            repeatUnit = RepeatUnit.day
        }
        var body: some View {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Content", text: $content)
                    DatePicker("Due Date", selection: .constant(Date()))
                }
                DisclosureGroup("Repeat") {

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
                    Button("Cancel") {
                        reset()
                        dismiss()
                    }
                    Button("Save") {
                        save()
                        reset()
//                        dismiss()
                    }
                }
            }

        }


        func didDismiss() {
            // Handle the dismissing action.
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
