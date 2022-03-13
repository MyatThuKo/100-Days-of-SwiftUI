## Project 7, iExpense (Day 36 - Day 38)

### Day 36 (Part 1) 
Things I learned
- Why @State only works with struct and not class 
- How to share SwiftUI state with @StateObject
  - To use @StateObject property wrapper => make the class @ObservableObject and add @Published wrapper to its objects
- How to show and hide views using sheet() and @EnvironmentObject(\.dismiss)
- How to delete items using onDelete()
- How to store user's settings/info using UserDefaults
- How to archive Swift obj using Codable
-----
### Day 37 (Part 2)
Things I learned
- How to build a list with ability to delete items 
- How to work with Identifiable items in SwiftUI
- How to share an observed obj with a new view 
- How to make changes permanent with UserDefaults 
-----
### Day 38 (Part 3) 
Wrap-up Day Challenges 
- Use the user's preferred currency 
- Add three modifiers for each amount Text
  1. One for amount lower than 10
  2. One for amount between 10 and 100 
  3. One for amount over 100
- Show two sections instead of one i.e. showing "Personal" and "Business" expenses separately 
