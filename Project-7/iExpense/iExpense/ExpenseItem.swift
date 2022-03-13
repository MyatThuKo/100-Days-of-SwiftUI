//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Myat Thu Ko on 3/12/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double 
}
