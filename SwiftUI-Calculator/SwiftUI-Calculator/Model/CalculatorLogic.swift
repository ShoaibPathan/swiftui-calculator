//
//  CalculatorLogic.swift
//  SwiftUI-Calculator
//
//  Created by Priscilla Ip on 2020-07-15.
//  Copyright © 2020 Priscilla Ip. All rights reserved.
//

import SwiftUI

struct CalculatorLogic {
    
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: CalculatorButton)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calculate(symbol: CalculatorButton) -> Double? {
        
        if let number = number {
            switch symbol {
            case .plusMinus:
                if number != 0 { return number * -1 }
            case .ac:
                return 0
            case .percent:
                return number * 0.01
            case .equals:
                return performTwoNumberCalculation(n2: number)
            default:
                intermediateCalculation = (n1: number, calcMethod: symbol)
            }
        }
        
        return nil
    }
    
    private func performTwoNumberCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1,
            let operation = intermediateCalculation?.calcMethod {
            
            switch operation {
            case .plus:
                return n1 + n2
            case .minus:
                return n1 - n2
            case .multiply:
                return n1 * n2
            case .divide:
                return n1 / n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        return nil
    }
    
}
