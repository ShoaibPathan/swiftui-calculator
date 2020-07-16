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
    
    var previousValue: Double?
    var currentNumber: Double?
    var activeOperation: CalculatorButton?
    var calculatedValue: Double = 0
    
    
    private var intermediateCalculation: (n1: Double, calcMethod: CalculatorButton)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    private mutating func resetCalculator() -> Double {
        previousValue = nil
        currentNumber = nil
        activeOperation = nil
        return 0
    }
    
    mutating func calculate(symbol: CalculatorButton) -> Double? {
        
        if let number = number {
            
            switch symbol {
            case .plusMinus:
                if number != 0 { return number * -1 }
            case .ac:
                return resetCalculator()
            case .percent:
                return number * 0.01
            case .equals:
                
                if let previousValue = previousValue {
                    
                    if let currentNumber = currentNumber {
                        return performCalculation(previousValue: previousValue, currentNumber: currentNumber)
                    } else {
                        currentNumber = number
                        return performCalculation(previousValue: previousValue, currentNumber: number)
                    }
                }
                
            default:

                activeOperation = symbol
                previousValue = previousValue != nil ? previousValue : number
            }
        }
        return nil
    }
    

    private mutating func performCalculation(previousValue: Double, currentNumber: Double) -> Double? {
        
        if let operation = activeOperation {
            switch operation {
            case .plus:
                calculatedValue = previousValue + currentNumber
            case .minus:
                calculatedValue = previousValue - currentNumber
            case .multiply:
                calculatedValue = previousValue * currentNumber
            case .divide:
                calculatedValue = previousValue / currentNumber

            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        
        self.previousValue = calculatedValue
        return calculatedValue
        
    }
    
    
}
                
                
                
                
                
                
                //            switch symbol {
                //            case .plusMinus:
                //                if number != 0 { return number * -1 }
                //            case .ac:
                //                return 0
                //            case .percent:
                //                return number * 0.01
                //
                //            case .equals:
                //
                //                if operation != nil {
                //
                //                    switch operation {
                //                    case .plus:
                //                        calculatedValue = previousValue + currentNumber
                //                    case .minus:
                //                        calculatedValue = previousValue - currentNumber
                //                    case .multiply:
                //                        calculatedValue = previousValue * currentNumber
                //                    case .divide:
                //                        calculatedValue = previousValue / currentNumber
                //                    default:
                //                        fatalError("The operation passed in does not match any of the cases.")
                //                    }
                //
                //                    self.previousValue = calculatedValue
                //                    return calculatedValue
                //
                //                } else {
                //
                //
                //
                //                }
                //
                //
                //
                //                //return performTwoNumberCalculation(n2: number)
                //            default:
                //
                //                self.operation = symbol // save the operator
                //                self.previousValue = previousValue != 0 ? previousValue : currentNumber
                //
                //                //intermediateCalculation = (n1: number, calcMethod: symbol)
                //            }

        
        //    private func performTwoNumberCalculation(n2: Double) -> Double? {
        //
        //        if let n1 = intermediateCalculation?.n1,
        //            let operation = intermediateCalculation?.calcMethod {
        //
        //            switch operation {
        //            case .plus:
        //                return n1 + n2
        //            case .minus:
        //                return n1 - n2
        //            case .multiply:
        //                return n1 * n2
        //            case .divide:
        //                return n1 / n2
        //            default:
        //                fatalError("The operation passed in does not match any of the cases.")
        //            }
        //        }
        //        return nil
        //    }
