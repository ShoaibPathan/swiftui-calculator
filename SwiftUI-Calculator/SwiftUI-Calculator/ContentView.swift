//
//  ContentView.swift
//  SwiftUI-Calculator
//
//  Created by Priscilla Ip on 2020-07-15.
//  Copyright © 2020 Priscilla Ip. All rights reserved.
//

import SwiftUI

enum CalculatorButton: String {
    
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide, decimal
    case ac, plusMinus, percent
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .plusMinus: return "±"
        case .percent: return "%"
        case .decimal: return "."
        case .equals: return "="
        default:
            return "AC"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
    
    var textColor: Color {
        switch self {
        case .ac, .plusMinus, .percent:
            return Color(.black)
        default:
            return .white
        }
    }
}

// Env object
// Global Application State
class GlobalEnvironment: ObservableObject {
    
    @Published var display = ""
    
    func receiveInput(calculatorButton: CalculatorButton) {
        self.display = calculatorButton.title
    }
    
}

struct ContentView: View {
    
    let spacing: CGFloat = 16
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]

    var body: some View {
        
        ZStack (alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack (spacing: self.spacing) {
                
                HStack {
                    Spacer()
                    Text(env.display).foregroundColor(.white)
                        .font(.system(size: 90))
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: self.spacing) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
}

struct CalculatorButtonView: View {
    
    var button: CalculatorButton
    let spacing: CGFloat = 16
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        Button(action: {
            
            self.env.receiveInput(calculatorButton: self.button)
            
        }) {
            Text(button.title)
                .font(.system(size: 32))
                .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * self.spacing)  / 4)
                .foregroundColor(button.textColor)
                .background(button.backgroundColor)
                .cornerRadius(self.buttonWidth(button: button))
        }
    }

    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * self.spacing)  / 4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * self.spacing)  / 4
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
