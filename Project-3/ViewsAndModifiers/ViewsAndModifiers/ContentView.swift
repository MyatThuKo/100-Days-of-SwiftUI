//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Myat Thu Ko on 2/20/22.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    // MARK: - Properties
    
    // MARK: - Body
    var body: some View {
        Text("Hello, world!")
            .titleStyle()
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
