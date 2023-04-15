//
//  SignUpViewController.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 28/10/22.
//

import UIKit
import ProgressHUD

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var backGroundImg:UIImageView!
    @IBOutlet weak var userNameTxtField:UITextField!
    @IBOutlet weak var userEmailTxtField:UITextField!
    @IBOutlet weak var userCityNameTxtField:UITextField!
    @IBOutlet weak var userDOBTxtField:UITextField!
    @IBOutlet weak var userPasswordTxtField:UITextField!
    @IBOutlet weak var userConfirmPasswordTxtField:UITextField!
    
    @IBOutlet weak var segmentedControl:UISegmentedControl!
    
    var datePicker = UIDatePicker()
    
    
    var signUpViewModel = SignUpViewModel()
    
    var genderType:String = "Male"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundTouch()
        setDatePicker()
        
    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func onclickSignUp(_ sender:Any){
        
        guard let userName = userNameTxtField.text, let userEmail = userEmailTxtField.text,let cityName = userCityNameTxtField.text, let userDOB = userDOBTxtField.text, let userPassword = userPasswordTxtField.text, let userConfirmPassword = userConfirmPasswordTxtField.text else {
            
            return
        }
        
        signUpViewModel.signUpDataModel.userName = userName
        signUpViewModel.signUpDataModel.userEmail = userEmail
        signUpViewModel.signUpDataModel.cityName = cityName
        signUpViewModel.signUpDataModel.dateOfBirth = userDOB
        signUpViewModel.signUpDataModel.password = userPassword
        signUpViewModel.signUpDataModel.confirmPassword = userConfirmPassword
        signUpViewModel.signUpDataModel.genderType = genderType
        
        if signUpViewModel.validateNewUserInputs() {
            //GO ahead and hit the API for real data
            ProgressHUD.show()
            
            RegisterNewUserManager.registerNewUserWith(email: userEmail, password: userPassword, userName: userName, city: cityName, genderType: genderType, dateofBirth: Date())
            {
                [weak self]  error in
                
                //ProgressHUD.dismiss()
                
                if error == nil
                {
                    ProgressHUD.showSuccess("Verification email sent!")
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
                else
                {
                    ProgressHUD.showError(error?.localizedDescription)
                    
                }
            }
        }
        else
        {
            ProgressHUD.showError(signUpViewModel.signUpDataModel.errorMessage)
            
        }
        
    }
    
    
    private func navigateToHomeVC(){
        guard let homeView = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifier.homeView) as? HomeViewController else {
            return
        }
        self.navigationController?.pushViewController(homeView, animated: true)
    }
    
    
    private func setupBackgroundTouch(){
        self.backGroundImg.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        backGroundImg.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyBoard(){
        self.view.endEditing(false)
    }
    
    @IBAction func indexChanged(_sender:UISegmentedControl){
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.genderType = "Male"
        case 1:
            self.genderType = "Female"
        default:
            break
        }
    }
    
    // MARK:- SetDatePicker
    
   private func setDatePicker(){
        
       self.datePicker.datePickerMode = .date
       self.datePicker.addTarget(self, action: #selector(getDate), for: .valueChanged)
       self.userDOBTxtField.inputView = datePicker
       let toolBar = UIToolbar()
       toolBar.barStyle = .default
       toolBar.isTranslucent = true
       toolBar.tintColor = UIColor().primanryColor()
       toolBar.sizeToFit()
        
       let cancelButton = UIBarButtonItem(title:"Cancel", style: .plain, target: self, action: #selector(hideKeyBoard))
       
       
       let doneButton = UIBarButtonItem(title:"Done", style: .plain, target: self, action: #selector(doneClicked))
       
       let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil
                                         , action: nil)
       
       
       toolBar.setItems([cancelButton,spaceButton, doneButton], animated: true)
       toolBar.isUserInteractionEnabled = true
       userDOBTxtField.inputAccessoryView = toolBar
       
    }
    
    @objc func getDate(){
        self.userDOBTxtField.text = datePicker.date.longDate()
    }
    
    @objc func doneClicked(){
        self.hideKeyBoard()
    }
}
