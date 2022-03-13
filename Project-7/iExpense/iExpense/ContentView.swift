//
//  ContentView.swift
//  iExpense
//
//  Created by Myat Thu Ko on 3/12/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Personal Expenses")) {
                    ForEach(expenses.items, id: \.id) { item in
                        if item.type == "Personal" {
                            HStack {
                                Text(item.name)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                    .foregroundColor(textColor(item.amount))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section(header: Text("Business Expenses")) {
                    ForEach(expenses.items, id: \.id) { item in
                        if item.type == "Business" {
                            HStack {
                                Text(item.name)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                    .foregroundColor(textColor(item.amount))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button {
                    showingAddExpense.toggle()
                } label: {
                    Image(systemName: "plus")
                })
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView(expenses: expenses)
            }
        }
    }
    
    func textColor(_ amount: Double) -> Color {
        if amount < 11 {
            return Color.green
        } else if amount > 11 && amount < 100 {
            return Color.blue
        } else {
            return Color.red
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
