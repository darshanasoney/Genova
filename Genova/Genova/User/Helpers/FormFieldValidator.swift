//
//  FormFieldValidator.swift
//  
//

import Foundation
import UIKit


//TODO:
class FormFieldValidator {
    
    var type : FormFieldValidatorType = .None
    var errorMessage : String
    var mandatory : Bool = true
    var priority: Int = 0
    var validateOnTextChange: Bool = false

    init(type: FormFieldValidatorType, mandatory : Bool = true, errorMessage : String = "Required", priority: Int = 0, validateOnTextChange: Bool = false) {
        self.type = type
        self.mandatory = mandatory
        self.errorMessage = errorMessage
        self.priority = priority
        self.validateOnTextChange = validateOnTextChange
    }
    
    func checkValiditity(forString stringToBeValidated: String) -> Bool {
        
        switch type {
            
        case .POBox:
            if StringValidator.shared.allowedSpecialValidCharactersForPassword(stringToBeValidated) {
                if StringValidator.shared.charactersCountGreaterThan(2, string: stringToBeValidated)  {
                    return !StringValidator.shared.charactersCountGreaterThan(10, string: stringToBeValidated)
                }
            }
            return false
        case .Phone:
            return StringValidator.shared.includesOnlyNumber(stringToBeValidated) && StringValidator.shared.charactersCountEqualTo(10, string: stringToBeValidated)
        case .Email:
            return StringValidator.shared.isValidEmail(stringToBeValidated)
        case .MinimumSevenCharactersLength:
            return StringValidator.shared.charactersCountGreaterThan(7, string: stringToBeValidated)
        case .OneNumber:
            return StringValidator.shared.includesOneNumber(stringToBeValidated)
        case .OneCharacter:
            return StringValidator.shared.includesOneLetter(stringToBeValidated)
        case .NonEmpty:
            return StringValidator.shared.charactersCountGreaterThan(1, string: stringToBeValidated)
        case .SpecialCharacters:
            return StringValidator.shared.allowedSpecialValidCharactersForPassword(stringToBeValidated)
        case .AllowedCharacters:
            return StringValidator.shared.containsOnlyValidCharacters(stringToBeValidated)
        case .MinimumTwoCharacters:
            return StringValidator.shared.hasMoreThanTwoCharacters(stringToBeValidated)
        case .MinimumTwoEnglishLetters:
            return StringValidator.shared.minimumTwoEnglishLetters(stringToBeValidated)
        case .MaximumHundredCharacters:
            return !StringValidator.shared.exceedsMaximumCharacters(stringToBeValidated)
            
        default:
            return true
        }
    }
}



enum FormFieldValidatorType: String {
    
    case Email
    case POBox
    case Phone
    case MinimumSevenCharactersLength
    case MinimumSevenCharactersAndOneLetterOneCharacter
    case NoSequence
    case NoRepetition
    case SpecialCharacters
    case NonEmpty
    case OneCharacter
    case MinimumTwoEnglishLetters
    case OneNumber
    case None
    case MinimumTwoCharacters
    case MaximumHundredCharacters
    case AllowedCharacters
}
