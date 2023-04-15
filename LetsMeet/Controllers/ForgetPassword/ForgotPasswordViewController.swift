//
//  ForgotPasswordViewController.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 28/10/22.
//

import UIKit
import ProgressHUD

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var userEmailText:UITextField!
    @IBOutlet weak var userOldPasswordText:UITextField!
    @IBOutlet weak var userNewPasswordText:UITextField!

    var loginViewModel = LoginViewModel()
    
    var userEmail:String = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpData()
    }
    
    private func setUpData(){
        self.userEmailText.text = userEmail
    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func onClickRest(_sender:Any){
        
        if userEmailText.text != "" {
            
            guard let userEmail = userEmailText.text , let userOldPassword = userOldPasswordText.text, let userNewPassword = userNewPasswordText.text else {
                return
            }
            
            loginViewModel.loginDataModel.userEmail = userEmail
            loginViewModel.loginDataModel.userPassword = userOldPassword
            
            if loginViewModel.validateUserInputs() {
                // Reset password
            }
            
            else
            {
                // Show Alert Message error
            }
            
            
        }
        else
        {
            // Show Alert Message error Message
        }
    }
    

}
