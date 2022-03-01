//
//  ContentView.swift
//  WordScramble
//
//  Created by Myat Thu Ko on 2/27/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var usedWords = [String]()
    @State private var wordCount = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Score: \(wordCount)")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        usedWords = []
                        wordCount = 0
                        startGame()
                    } label: {
                        Text("Restart")
                    }
                }
            }
        }
    }
    
    func addWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 2 else {
            wordError(title: "Too short!", message: "Please enter the word longer than 3 characters.")
            return
        }
        
        guard answer != rootWord else {
            wordError(title: "Same as the given word", message: "Please enter the word other than the original word!")
            return
        }
        
        guard isDuplicated(word: answer) else {
            wordError(title: "Word used already", message: "Please enter another word! No Duplicate allows!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "\"\(answer)\" cannot be spelled from \"\(rootWord)\"")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Incorrect Spelling/Word", message: "\(answer) does not exist!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        wordCount += answer.count
        newWord = ""
    }
    
    func startGame() {
        if let bundleURL = Bundle.main.url(forResource: "wordsList", withExtension: ".txt") {
            if let startWordsList = try? String(contentsOf: bundleURL) {
                let allWords = startWordsList.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                
                return
            }
        }
        
        fatalError("Could not load wordsList.txt file from bundle!")
    }
    
    func isDuplicated(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
        newWord = ""
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
