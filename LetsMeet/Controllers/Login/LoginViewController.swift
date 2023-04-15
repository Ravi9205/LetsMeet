//
//  LoginViewController.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 27/10/22.
//

import UIKit
import ProgressHUD

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userEmailField:UITextField!
    @IBOutlet weak var userPassword:UITextField!
    @IBOutlet weak var backGroundImg:UIImageView!
    
    var loginResource = LoginResource()
    
    var validationResult = ValidationResult()
    
    var loginViewModel = LoginViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .dark
        setupBackgroundTouch()
    }
    
    
    @IBAction func onClickSignUp(_ sender: Any) {
        guard let  signUp = self.storyboard?.instantiateViewController(withIdentifier:ViewControllerIdentifier.signUpView) as? SignUpViewController else { return }
        self.navigationController?.pushViewController(signUp, animated: true)
        
    }
    
    @IBAction func onclickForgot(_ sender: Any) {
        
        if userEmailField.text != ""  {
            guard let userEmail = userEmailField.text else { return }
            loginViewModel.loginDataModel.userEmail = userEmail
            loginViewModel.loginDataModel.isLogin = true
            
            if loginViewModel.validateUserInputs() {
               // navigateToForgetView(email:userEmail)
                
                LoginManager.resetPasswordFor(email: userEmail) { error in
                    if error != nil {
                        ProgressHUD.showError(error!.localizedDescription)
                    }
                    else
                    {
                        ProgressHUD.showSuccess("Password reset link has been successfully sent to your registered email address please check!")
                    }
                }
                
            }
            else
            {
                //Show Incorrect Email ID  Prompt
                ProgressHUD.showError(AlertMessages.incorrectEmail)
            }
            
        }
        else
        {
            //Show an Error Prompt an empty Email
            ProgressHUD.showError(AlertMessages.emptyEmail)
            
        }
    }
    
    private func navigateToForgetView(email:String){
        guard let  forgotView = self.storyboard?.instantiateViewController(withIdentifier:ViewControllerIdentifier.forgotPasswordView) as? ForgotPasswordViewController else { return }
        forgotView.userEmail = email
        self.navigationController?.pushViewController(forgotView, animated: true)
    }
    
    @IBAction func onClickLogin(_sender:Any){
        
        guard let userEmail = userEmailField.text, let userPassword = userPassword.text else {
            return
        }
        
        loginViewModel.loginDataModel.userEmail = userEmail
        loginViewModel.loginDataModel.userPassword = userPassword
        
        let loginRequest = LoginRequest(userEmail:loginViewModel.loginDataModel.userEmail, userPassword: loginViewModel.loginDataModel.userPassword)
        
        if loginViewModel.validateUserInputs() {
            
            ProgressHUD.show()
            
            LoginManager.loginUserWith(email: userEmail, password: userPassword) {[weak self] error, isVarified in
                
                if error == nil {
                    if isVarified {
                        ProgressHUD.dismiss()
                        DispatchQueue.main.async {
                            self?.goToHomeView()
                        }
                        
                    }
                    else
                    {
                        ProgressHUD.showError("Email id is not varified please varify it once before logged In!")
                    }
                }
                else
                {
                    ProgressHUD.showError(error!.localizedDescription)
                }
            }
        }
        else
        {
            
            ProgressHUD.showError(loginViewModel.loginDataModel.errorMessage)
        }
    }
    
    
    func goToHomeView(){
        
        guard let mainView = UIStoryboard.init(name:"Main", bundle: nil).instantiateViewController(withIdentifier:"TabBarController") as? UITabBarController else { return }
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: false, completion: nil)
        
    }
    
    
    private func setupBackgroundTouch(){
        self.backGroundImg.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        backGroundImg.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyBoard(){
        self.view.endEditing(false)
    }
    
    
    //MARK:- Login navigation
    func navigateToLoginVC(){
        guard let loginView = self.storyboard?.instantiateViewController(withIdentifier:"") as? LoginViewController else {
            return
        }
        self.navigationController?.pushViewController(loginView, animated: true)
    }
    
    
}
