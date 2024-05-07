//
//  StringValidator.swift
//  
//

import Foundation

class StringValidator {
    
    static let shared = StringValidator()
    
    static let alphabetString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    func isValidEmail(_ string :String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: string)
    }
    
    func includesOneNumber(_ string: String) -> Bool {
        
         return string.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
    }
    
    func includesOnlyNumber(_ string: String) -> Bool {
        
         return string.rangeOfCharacter(from: CharacterSet.letters) == nil
    }
    
    func includesOneLetter(_ string: String) -> Bool {

        return string.rangeOfCharacter(from: CharacterSet.capitalizedLetters) != nil || string.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil
    }
    
    func containsSymbols(_ string: String) -> Bool {
        
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "$@;#^!%*&")) != nil
    }
    
    func charactersCountGreaterThan(_ value: Int, string: String, shouldConsiderWhiteSpaces: Bool = true) -> Bool {
        
        if shouldConsiderWhiteSpaces {
            if string.count > 0 {
                return string.trimmingCharacters(in: CharacterSet.whitespaces).count >= value
            } else {
                return true
            }
        } else {
            return string.count >= value
        }
    }
    
    func charactersCountEqualTo(_ value: Int, string: String) -> Bool {
        return string.count == value
    }
    
    func includesRepeatingCharacters(_ string: String) -> Bool {
        
        var dict: [Character: Int] = [:]
        for (_, char) in string.enumerated() {
            if var value = dict[char] {
                value = value + 1
                dict[char] = value
                if value >= 3 {
                    return true
                }
            } else {
                dict[char] = 1
            }
        }
        return false
    }
    
    func includesRepeatingCharactersForPassword(_ string: String) -> Bool {
           
           var i = 0
          while (i < string.count - 2){
              
              let subStr1 = string.substring(fromIndex: i, toIndex: i)
              let subStr2 = string.substring(fromIndex: i + 1, toIndex: i + 1)
              let subStr3 = string.substring(fromIndex: i + 2, toIndex: i + 2)
              
              if subStr1 == subStr2 && subStr2 == subStr3 {
                  return true
              }
               i = i + 1
           }
        return string.count == 0 //false
       }
       
    
    func includesSequentialCharacters(_ string: String) -> Bool {
        
        var stringsArray : [String] = []
        
        let upperCasedString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        stringsArray.append(upperCasedString)
        
        let lowerCasedString = upperCasedString.lowercased()
        stringsArray.append(lowerCasedString)
        
        let numbers = "0123456789"
        stringsArray.append(numbers)
        
        let numbersReversed = String(numbers.reversed())
        stringsArray.append(numbersReversed)
        
        let upperCasedStringReversed = String(upperCasedString.reversed())
        stringsArray.append(upperCasedStringReversed)
        
        let lowerCasedStringReversed = String(lowerCasedString.reversed())
        stringsArray.append(lowerCasedStringReversed)
        
        var i : Int = 0
        
        while (i < string.count - 2) {
            
            let subStr = string.substring(fromIndex: i, toIndex: i+2)
            
            for validatorString in stringsArray {
                
                if validatorString.contains(subStr) {
                    return true
                }
            }
            
            i = i + 1
        }
        
        return string.count == 0 //false
    }
    
    func hasMoreThanTwoCharacters(_ string : String!) -> Bool {
      
        return string.stringByRemoving(" ").count >= 2
        
    }
    
    func minimumTwoEnglishLetters(_ string: String!) -> Bool {
       
        let whiteSpaceTrimmedString = string.stringByRemoving(" ")
        
        guard whiteSpaceTrimmedString.count >= 2 else {
            return false
        }
        
        let str = whiteSpaceTrimmedString.stringByRemoving(StringValidator.alphabetString).stringByRemoving(StringValidator.alphabetString.lowercased())
    
        let diff = whiteSpaceTrimmedString.count - str.count
        return diff >= 2
    }
    
    func exceedsMaximumCharacters(_ string : String!) -> Bool {
        
        return string.count > 100
        
    }
    
    func allowedSpecialValidCharactersForPassword(_ string: String) -> Bool {
        
        var charSet = CharacterSet.alphanumerics
        charSet.formUnion(CharacterSet(charactersIn: "$@;#^!%*&"))
        return (string.count != 0 && string.components(separatedBy: charSet).joined(separator: "").count == 0)
        
    }
    
    func containsOnlyValidCharacters(_ string: String) -> Bool {
        
        var charSet = CharacterSet.alphanumerics
        
        charSet.formUnion(CharacterSet(charactersIn: "'‘’()- "))
        
        let components = string.components(separatedBy: charSet)
        
        return components.joined(separator: "").count == 0
        
    }
}

extension String {
    
    func stringByRemoving(_ chars: String) -> String {
        
        let characterSet = CharacterSet(charactersIn: chars)
        let componenets = self.components(separatedBy: characterSet)
        return componenets.joined(separator: "")
    }
    
    func substring(fromIndex: Int, toIndex:Int)->String{
        if self.count > 0 {
            let startIndex = self.index(self.startIndex, offsetBy: fromIndex)
            let endIndex = self.index(startIndex, offsetBy: toIndex-fromIndex)
            if (startIndex <= endIndex) {
                return String(self[startIndex...endIndex])
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
}
