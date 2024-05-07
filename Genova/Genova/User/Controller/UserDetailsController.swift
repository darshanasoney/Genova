//
//  UserDetailsController.swift
//  Genova
//
//  Created by home on 21/08/23.
//

import Foundation
import UIKit
import CountryList

class UserDetailsController: UIViewController, FormController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nextButton : UIButton? {
        didSet{
            disableNextButton()
        }
    }
    
    var textField = MFTextField()
    var countryList = CountryList()
    var errorMessage = "Required"
    var formData: [FormFieldData] = []
    
    lazy var formTableViewDelegate: FormTableViewDelegate = {
        
        let formDelegate = FormTableViewDelegate()
        formDelegate.controller = self
        
        return formDelegate
    }()
    
    @IBAction func cancelPressed(_ sender: AnyObject) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickNextButton(_ sender: UIButton) {
        nextPressed()
    }
    fileprivate func enableNextButton() {
        
        nextButton?.isEnabled = true
        nextButton?.backgroundColor = UIColor.gray
    }
    
    fileprivate func disableNextButton() {
        
        nextButton?.isEnabled = false
        nextButton?.backgroundColor = UIColor.lightGray
    }
    
    fileprivate func nextPressed() {
        
        if formTableViewDelegate.explicityCheckForValidation() {
            self.view.endEditing(true)
            if let vc =  self.storyboard?.instantiateViewController(withIdentifier: "SuccessController") as? SuccessController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryList.delegate = self
        
        setUpFormData()
        registerFormTableViewCell()
        setUpTableView()
        addTapGestureRecognizer()
    }
    
    func addTapGestureRecognizer(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dissmiss))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func dissmiss(){
        self.view.endEditing(true)
    }
    
    func setUpFormData() {
        
        let titleField = FormFieldData(placeHolderText: "Title",
                                          type: .title,
                                          validators: [
                                            FormFieldValidator(type: .NonEmpty, errorMessage : "Required")
                                          ],
                                          heightConstraint : 84
        )
        
        let firstNameField = FormFieldData(placeHolderText: "Full name",
                                              type: .firstName,
                                              validators: [
                                                
                                                FormFieldValidator(
                                                    type: .NonEmpty,
                                                    errorMessage: "Required",
                                                    priority: 5
                                                ),
                                                FormFieldValidator(
                                                    type: .AllowedCharacters,
                                                    errorMessage : "Can contain any of the following special characters( ) - ' and space",
                                                    priority: 4,
                                                    validateOnTextChange: true
                                                ),
                                                
                                                FormFieldValidator(
                                                    type: .MinimumTwoEnglishLetters,
                                                    errorMessage : "Enter at-least two English letters",
                                                    priority: 2,
                                                    validateOnTextChange: true
                                                ),
                                                FormFieldValidator(
                                                    type: .MinimumTwoCharacters,
                                                    errorMessage : "Name must consist of at least two characters",
                                                    priority: 3,
                                                    validateOnTextChange: true
                                                ),
                                                FormFieldValidator(
                                                    type: .MaximumHundredCharacters,
                                                    errorMessage : "Please re-enter maximum length 100 characters",
                                                    priority: 1
                                                )
                                                
                                               ],
                                              heightConstraint : 84,
                                              shouldValidateOnTextChange: true
        )
        
        let addressField = FormFieldData(placeHolderText: "Address",
                                               type: .firstName,
                                               validators: [
                                                FormFieldValidator(
                                                    type: .NonEmpty,
                                                    errorMessage: "Required",
                                                    priority: 1
                                                ),
                                                
                                                FormFieldValidator(
                                                    type: .MinimumTwoEnglishLetters,
                                                    errorMessage : "Enter at-least two English letters",
                                                    priority: 2,
                                                    validateOnTextChange: true
                                                ),
                                                FormFieldValidator(
                                                    type: .MinimumTwoCharacters,
                                                    errorMessage : "Address must consist of at least two characters",
                                                    priority: 3,
                                                    validateOnTextChange: true
                                                ),
                                                FormFieldValidator(
                                                    type: .MaximumHundredCharacters,
                                                    errorMessage : "Please re-enter maximum length 100 characters",
                                                    priority: 4
                                                )
                                                ],
                                                heightConstraint : 84,
                                                shouldValidateOnTextChange: true
        )
        
        let poboxField = FormFieldData(placeHolderText: "PO Box",
                                          type: .poBox,
                                          validators: [
                                            FormFieldValidator(
                                                type: .NonEmpty,
                                                errorMessage: "Required",
                                                priority: 1
                                            ),
                                            FormFieldValidator(
                                                type: .POBox,
                                                errorMessage : "Invalid format",
                                                priority: 2
                                            )
                                          ],
                                          heightConstraint : 84
        )
        
        let countryField = FormFieldData(placeHolderText: "Country",
                                          type: .county,
                                          validators: [
                                            FormFieldValidator(
                                                type: .NonEmpty,
                                                errorMessage: "Required",
                                                priority: 1
                                            )
                                          ],
                                          heightConstraint : 84
        )
        
        let cityField = FormFieldData(placeHolderText: "City",
                                          type: .city,
                                          validators: [
                                            FormFieldValidator(
                                                type: .NonEmpty,
                                                errorMessage: "Required",
                                                priority: 1
                                            ),
                                            FormFieldValidator(
                                                type: .MinimumTwoCharacters,
                                                errorMessage : "City must consist of at least two characters",
                                                priority: 2,
                                                validateOnTextChange: true
                                            )
                                          ],
                                          heightConstraint : 84
        )
        
        let codeField = FormFieldData(placeHolderText: "Code",
                                          type: .code,
                                          validators: [
                                            FormFieldValidator(
                                                type: .NonEmpty,
                                                errorMessage: "Required",
                                                priority: 1
                                            ),
                                            FormFieldValidator(
                                                type: .MinimumTwoCharacters,
                                                errorMessage : "Code must consist of at least two digits",
                                                priority: 2,
                                                validateOnTextChange: true
                                            )
                                          ],
                                          heightConstraint : 84
        )
        
        let phoneField = FormFieldData(placeHolderText: "Mobile Number",
                                          type: .phone,
                                          validators: [
                                            FormFieldValidator(
                                                type: .NonEmpty,
                                                errorMessage: "Required",
                                                priority: 1
                                            ),
                                            FormFieldValidator(
                                                type: .Phone,
                                                errorMessage : "Invalid format",
                                                priority: 2
                                            )
                                          ],
                                          heightConstraint : 84
        )
        
        self.formData = [titleField,firstNameField,addressField, poboxField,countryField, cityField, codeField, phoneField]
    }
    
    func setUpTableView() {
        
        tableView.delegate = formTableViewDelegate
        tableView.dataSource = formTableViewDelegate
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
    }
    
    func onDone() {
        nextPressed()
    }
    
    func textFieldEditingChanged(withFormData data: FormFieldData, textField: MFTextField) {
        
        switch data.type {
        case .firstName:
            let givenName = textField.text ?? ""
        default:
            break
        }
        
        let valid = formTableViewDelegate.explicityCheckForValidation(false)
        
        nextButton?.isEnabled = valid
        nextButton?.backgroundColor = valid ? UIColor.darkGray : UIColor.lightGray
    }
    
    func textFieldValidationFailed(at validator: FormFieldValidator,withFormData data: FormFieldData, textField: MFTextField,updateUI: Bool) {
        
    }
    
    func textFieldValidationSuccess(at validator: FormFieldValidator,withFormData data: FormFieldData, textField: MFTextField,updateUI: Bool) {
        print(data.cell.formField.text ?? "")
    }
    
    func textFieldEditingDidEnd(_ formData: FormFieldData, textField: MFTextField) {
        
        switch formData.type {
        case .title :
            
            let honorificPrefix = textField.text
            
           let valid = formTableViewDelegate.explicityCheckForValidation(false)
            
            nextButton?.isEnabled = valid
            nextButton?.backgroundColor = valid ? UIColor.darkGray : UIColor.lightGray
            
        default:
            break
        }
        
    }
    
    func textFieldEditingDidBegin(_ formData: FormFieldData, textField: MFTextField) {
        switch formData.type {
            case .county:
                self.view.endEditing(true)
                let navController = UINavigationController(rootViewController: countryList)
                self.textField = textField
                self.present(navController, animated: true, completion: nil)
                break
            
            default:
                break
        }
    }
    
    func totalFormValidationSuccess() {
        
    }
    
    func designCell(_ cell: FormTableViewCell, atIndexPath: IndexPath) {
        
        if cell.formData.type != .phone {
            cell.formField.autocapitalizationType = .words
            cell.formField.returnKeyType = .next
            cell.formField.enablesReturnKeyAutomatically = false
        } else {
            cell.formField.returnKeyType = .done
            cell.formField.enablesReturnKeyAutomatically = true
        }
    }
}

extension UserDetailsController : CountryListDelegate {
    
    func selectedCountry(country: Country) {
        self.textField.text = country.name
        let form = self.formData.filter { form in
            return form.type == .code
        }.first
        
        form?.cell.formField.text = "+" + country.phoneExtension
        form?.cell.formField.isUserInteractionEnabled = false
    }
}
