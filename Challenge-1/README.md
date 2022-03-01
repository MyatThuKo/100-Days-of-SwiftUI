## Challenge day, Unit Convertor (Day 19)

### Day 19 (Challenge 1)
Have to build an app to handle unit conversions and decide to do Length Conversions 

Tools I used
- @State binding properties 
- TextField and Computed Property
- Measurement and UnitLength classes 
- Form, Section, Picker and NavigationView 

### Conversion using Unit and Measurement  
```swift
let unitFrom = Measurement(value: 100, unit: UnitLength.feet)
let unitTo = unitFrom.convert(to: UnitLength.yards)
```

### More Resources 
Types of units such as UnitLength, UnitArea etc. are shown in Dimension page
- To learn more about Unit (class) -> [Apple Docs](https://developer.apple.com/documentation/foundation/unit)
- To learn more about Dimension (class) -> [Apple Docs](https://developer.apple.com/documentation/foundation/dimension)
- To learn more about Measurement (struct) -> [Apple Docs](https://developer.apple.com/documentation/foundation/measurement) 
