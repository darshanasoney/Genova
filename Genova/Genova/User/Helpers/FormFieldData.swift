//
//  FormFieldData.swift
//  
//

import Foundation
import UIKit

@objcMembers
class FormFieldData: Equatable {
    
    lazy var cell : FormTableViewCell = {
        return  UINib(nibName: "FormTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil).first as! FormTableViewCell
    }()
    
    var placeHolderText: String!
    var type: FormTableViewCellType = .default
    var shouldValidateOnTextChange: Bool
    
    var validators: [FormFieldValidator] = []
    
    var defaultErrorMessage: String
    var heightConstraint : CGFloat = 70
    var shouldCheckValidationForAll : Bool
    
    init(placeHolderText: String, type : FormTableViewCellType, validators: [FormFieldValidator] = [], heightConstraint:CGFloat = 70, defaultErrorMessage: String = "Required", shouldValidateOnTextChange: Bool = false, shouldCheckValidationForAll: Bool = false) {
        
        self.placeHolderText = placeHolderText
        self.type = type
        self.validators = validators
        self.heightConstraint = heightConstraint
        self.defaultErrorMessage = defaultErrorMessage
        self.shouldValidateOnTextChange = shouldValidateOnTextChange
        self.shouldCheckValidationForAll = shouldCheckValidationForAll
    }
}

func ==(lhs: FormFieldData, rhs: FormFieldData) -> Bool {
    return lhs.type == rhs.type
}


import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class FormTableViewCell: UITableViewCell {
    
    @IBOutlet weak var formField : MFTextField!
    
    @IBOutlet weak var formFieldHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var formFieldBottomConstraint: NSLayoutConstraint!
    
    var rightViewWidth : CGFloat = 122
    var rightViewHeight : CGFloat = 22
    var selectedIndex = 0
    
    let titlePickerView = UIPickerView()
    
    var titleDataSource = ["Mr","Mrs","Ms","Miss","Dr"]
    
    func setUpFormField() {
        
        formFieldHeightConstraint.constant = formData.heightConstraint
        
        formField.tintColor = UIColor.darkGray
        formField.textColor = UIColor.black
        formField.defaultPlaceholderColor = UIColor.darkGray
        formField.placeholderColor = UIColor.darkGray
        formField.placeholderAnimatesOnFocus = true
        formField.clearButtonMode = .never
        formField.textPadding = CGSize(width: 5, height: 4)
        formField.errorPadding = CGSize.zero
        
        formField.placeholderFont = UIFont.systemFont(ofSize: 12)
        formField.errorFont = UIFont.systemFont(ofSize: 12)
        formField.errorColor = UIColor.red
        formField.underlineColor = UIColor.gray
        formField.underlineHeight = 1
        formField.underlineEditingHeight = 1
        if #available(iOS 11.0, *) {
            formField.pasteDelegate = self
        } else {
            // Fallback on earlier versions
        }
        
        if formData.type == .poBox || formData.type  == .phone || formData.type  == .code {
            formField.keyboardType = .numberPad
        } else {
            formField.keyboardType = .default
        }
        
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [
            NSAttributedString.Key.font : font,
            ] as [NSAttributedString.Key : AnyObject]
        
        let attributedString = NSAttributedString(string: formData.placeHolderText, attributes:attributes)
        
        formField.attributedPlaceholder = attributedString
        
        formField.delegate = self
        formField.addTarget(self, action: #selector(FormTableViewCell.textFieldValueChanged), for: UIControl.Event.editingChanged)
        
        if formData.type == .title {
            
            formField.inputView = setupPickerView()
            formField.inputAccessoryView = setupInputAccessroryView()
            
        } else {
            
            formField.inputView =  nil
            formField.inputAccessoryView =  nil
            
        }
    }
    
    var delegate: FormTableViewCellDelegate!

    var formData: FormFieldData! {
        didSet {
            setUpFormField()
        }
    }
    
    func setupPickerView() -> UIPickerView {
        
        titlePickerView.delegate = self
        titlePickerView.dataSource = self
        
        return titlePickerView
        
    }
    
    fileprivate func checkAndSetDefaultValue() {
        
        if formField.text == nil || formField.text == "" {
            self.pickerView(titlePickerView, didSelectRow: 0, inComponent: 0)
            selectedIndex = 0
        }
    }
    
    func setupInputAccessroryView() -> UIView {
        
        let viewHeight: CGFloat = 40
        let buttonHeight: CGFloat = 26
        let buttonWidth: CGFloat = 60
        let buttonTopSpace: CGFloat = viewHeight/2 - buttonHeight/2
        let buttonLeadingSpace: CGFloat = self.contentView.bounds.width - buttonWidth - 9
        
        let accessroryView = UIView()
        accessroryView.backgroundColor = UIColor.gray
        accessroryView.frame = CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: viewHeight)
        
        let accessroryButton = UIButton()
        accessroryButton.frame = CGRect(x: buttonLeadingSpace, y: buttonTopSpace, width: buttonWidth, height: buttonHeight)
        accessroryButton.backgroundColor = UIColor.clear
        accessroryButton.setTitle("Done", for: UIControl.State())
        accessroryButton.setTitleColor(UIColor.white, for: UIControl.State())
        accessroryButton.addTarget(self, action: #selector(onClickDoneButton), for: .touchUpInside)
        accessroryButton.layer.borderWidth = 1
        accessroryButton.layer.borderColor = UIColor.white.cgColor
        accessroryButton.layer.cornerRadius = 2
        accessroryButton.clipsToBounds = true
        accessroryButton.autoresizingMask = .flexibleLeftMargin
        
        accessroryView.addSubview(accessroryButton)
        
        return accessroryView
    }
    
    @objc func onClickDoneButton() {
        delegate.focusNextField(formData, textField: formField)
    }
    
}

extension FormTableViewCell : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if formData.type == .title {
           checkAndSetDefaultValue()
            titlePickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
        }
        
        delegate.textFieldEditingDidBegin(formData, textField: formField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate.textFieldEditingDidEnd(formData, textField: formField)
    }
    
    @objc func textFieldValueChanged() {
        delegate.textFieldEditingDidChange(formData, textField: formField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            delegate.focusNextField(formData, textField: formField)

        } else if textField.returnKeyType == .done {
            delegate.onDone(formData, textField: formField)
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if formData.type == .firstName {
         
            let res = string != "" ? textField.text?.count < 100 : true
            
            if !res {
                if let errorMessage = self.formData.validators.filter({$0.type == .MaximumHundredCharacters}).first?.errorMessage {
                    self.formField.setError(errorMessage)
                }
            }
            return res
        }
        
        return true
    }
    
}

extension FormTableViewCell : UIPickerViewDataSource,UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return titleDataSource.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return titleDataSource[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        formField.text = titleDataSource[row]
        selectedIndex = row
    }
}

extension MFTextField {
    
    func setError(_ errorMessage: String) {
        var error: NSError? = nil
        error = self.errorWithLocalizedDescription(errorMessage)
        self.setError(error, animated: true)
    }
    
    func errorWithLocalizedDescription(_ localizedDescription: String) -> NSError? {
        let userInfo = [NSLocalizedDescriptionKey: localizedDescription]
        return NSError(domain: ErrorDomain, code: ErrorInvalidEmail, userInfo: userInfo)
    }
    
}

extension FormTableViewCell: UITextPasteDelegate {
    
    @available(iOS 11.0, *)
    func textPasteConfigurationSupporting(_ textPasteConfigurationSupporting: UITextPasteConfigurationSupporting, transform item: UITextPasteItem) {
        
        if formData.type == .title {
            
            item.setNoResult()
        }
        else {
            item.setDefaultResult()
        }
    }
}

enum FormTableViewCellType {
    
    case `default`
    case title
    case firstName
    case poBox
    case city
    case phone
    case county
    case code
}

let ErrorDomain = "GenovaErrorDomain"
let ErrorInvalidEmail = 1001;
let ErrorInvalidPassword = 1002;

