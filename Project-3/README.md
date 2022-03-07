## Project 3, Views and Modifiers (Day 23 - Day 24)

### Day 23 (Part 1)
Things I learned 
- Why SwiftUI uses struct instead of class for views 
- What is behind the main SwiftUI view
- The importance of modifier order 
- Conditional and Environment modifiers
- Views as properties and View Compositions
- Custom modifiers and Custom containers
-----
### Day 24 (Part 2) 
Wrap-up Day Challenges 
- Add a conditional modifier to change the color of a text when 0% tip is selected 

```swift 
Text(total, format: .currency(code: Locale.current.currencyCode ?? "USD")).foregroundColor(tipPercentage == 0 ? .red : .black)
```

- Replace an Image with a view composition "FlagImage()"
```swift
struct FlagImage: View {
  var country: String      
  
  var body: some View {
    Image(country)
      .renderingMode(.original)
      .clipShape(Capsule())
      .shadow(radius: 10)
  }
}
```
- Create a custom ViewModifier with a View extension showing a large blue title 
```swift 
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
```
