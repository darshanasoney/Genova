//
//  FormTableViewDelegate.swift
//  
//

import Foundation
import UIKit
import MaterialTextField
 
class FormTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var controller : FormController!
    
    fileprivate func getCellOfType(_ cellType: FormTableViewCellType) -> FormTableViewCell? {
        
        for formFieldData in controller.formData {
            if formFieldData.type == cellType {
                return formFieldData.cell
            }
        }
        return nil
    }
    
    func showErrorOn(_ cellType: FormTableViewCellType, errorMessage: String) {
        
        if let cell = getCellOfType(cellType) {
            self.setError(errorMessage, textField: cell.formField)
        }
    }
    
    func makeFirstResponder(_ cellType: FormTableViewCellType) {
        
        if let cell = getCellOfType(cellType) {
            cell.formField.becomeFirstResponder()
        }
    }
    
    func explicityCheckForValidation(_ updateUI: Bool = true) -> Bool {
        
        var allAreValid: Bool = true
        
        for formFieldData in controller.formData {
            
            if !checkForValidationOn(formFieldData.cell.formField, formData: formFieldData, showError: updateUI) {
                
                allAreValid = false
                
            } else {
                
                removeErrorOn(formFieldData.cell.formField)
            }
        }
        return allAreValid
    }
    
    func checkForValidation(_ cellType: FormTableViewCellType, updateUI: Bool = true) -> Bool {
        
        if let cell = getCellOfType(cellType) {
            
            return checkForValidationOn(cell.formField, formData: cell.formData,showError: updateUI)
                
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.formData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = controller.formData[indexPath.row].cell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.formData = controller.formData[indexPath.row]
        
        controller.designCell(cell,atIndexPath: indexPath)
        return cell
    }
    
    func setError(_ errorMessage: String, textField: MFTextField) {
        var error: NSError? = nil
        error = self.errorWithLocalizedDescription(errorMessage)
        textField.setError(error, animated: true)
    }
    
    func errorWithLocalizedDescription(_ localizedDescription: String) -> NSError? {
        let userInfo = [NSLocalizedDescriptionKey: localizedDescription]
        return NSError(domain: ErrorDomain, code: ErrorInvalidEmail, userInfo: userInfo)
    }
    
    fileprivate func removeErrorOn(_ textField: MFTextField) {
        setError("", textField: textField)
    }
    
    func checkForValidationOn(_ textField: MFTextField, formData: FormFieldData, onTextDidChange: Bool = false, showError: Bool = true) -> Bool {
        
        let stringToBeValidated = textField.text ?? ""
            
        var isValid: Bool = true
        
        let sortedValidators = formData.validators.sorted(by: {$0.priority > $1.priority})
        
        for validator in sortedValidators {
            
            if onTextDidChange && !validator.validateOnTextChange {
                continue
            }
            
            if !validator.checkValiditity(forString: stringToBeValidated) {
                
                if validator.mandatory && !formData.shouldCheckValidationForAll {
                    
                    if showError {
                        self.setError(validator.errorMessage, textField: textField)
                    }
                
                    controller.textFieldValidationFailed(at: validator, withFormData: formData, textField: textField, updateUI: showError)
                    return false
                    
                } else if validator.mandatory {
                    isValid = false
                }
                
                controller.textFieldValidationFailed(at: validator, withFormData: formData, textField: textField, updateUI: showError)
                
            } else {
                controller.textFieldValidationSuccess(at: validator, withFormData: formData, textField: textField, updateUI: showError)
            }
        }
        
        //Show the default error message incase of validation fail
        if !isValid && showError {
            self.setError(formData.defaultErrorMessage, textField: textField)
        } else if isValid {
            self.removeErrorOn(textField)
        }
        return isValid
    }
}

extension FormTableViewDelegate : FormTableViewCellDelegate {
    
    
    func onDone(_ formData: FormFieldData, textField: MFTextField) {
        controller.onDone()
    }
    
    func focusNextField(_ formData: FormFieldData, textField: MFTextField) {
        if let index = controller.formData.firstIndex(of: formData) {
            if index < controller.formData.count - 1 {
                controller.formData[index + 1].cell.formField.becomeFirstResponder()
            }
        }
    }
    
    func textFieldEditingDidBegin(_ formData: FormFieldData, textField: MFTextField) {
        removeErrorOn(textField)
        controller.textFieldEditingDidBegin(formData, textField: textField)
    }
    
    func textFieldEditingDidEnd(_ formData: FormFieldData, textField: MFTextField) {
        
        _ = checkForValidationOn(textField, formData: formData, showError: true)
        controller.textFieldEditingDidEnd(formData, textField: textField)
    }
    
    func textFieldEditingDidChange(_ formData: FormFieldData, textField: MFTextField) {
        if formData.shouldValidateOnTextChange {
            _ = checkForValidationOn(textField, formData: formData,onTextDidChange: true, showError: true)
        }
        controller.textFieldEditingChanged(withFormData: formData, textField: textField)
    }
}

protocol FormTableViewCellDelegate {
    
    func textFieldEditingDidBegin(_ formData: FormFieldData, textField: MFTextField)
    func textFieldEditingDidEnd(_ formData: FormFieldData, textField: MFTextField)
    func textFieldEditingDidChange(_ formData: FormFieldData, textField: MFTextField)
    func focusNextField(_ formData: FormFieldData, textField: MFTextField)
    func onDone(_ formData: FormFieldData, textField: MFTextField)
}

protocol FormController {
    
    func textFieldEditingChanged(withFormData data: FormFieldData, textField: MFTextField)
    func textFieldValidationFailed(at validator: FormFieldValidator,withFormData data: FormFieldData, textField: MFTextField, updateUI: Bool)
    func textFieldValidationSuccess(at validator: FormFieldValidator,withFormData data: FormFieldData, textField: MFTextField, updateUI: Bool)
    
    func textFieldEditingDidEnd(_ formData: FormFieldData, textField: MFTextField)
    func textFieldEditingDidBegin(_ formData: FormFieldData, textField: MFTextField)
    
    func onDone()
    
    func totalFormValidationSuccess()
    
    func registerFormTableViewCell()
    
    func designCell(_ cell: FormTableViewCell, atIndexPath: IndexPath)
    var formData : [FormFieldData] {get set}
    
    var tableView: UITableView! {get set}
}

extension FormController {
    
    func registerFormTableViewCell() {
        
        self.tableView.register( UINib(nibName: "FormTableViewCell", bundle: nil), forCellReuseIdentifier: "FormTableViewCell")
    }
    
    func designCell(_ cell: FormTableViewCell, atIndexPath: IndexPath) {}
}
