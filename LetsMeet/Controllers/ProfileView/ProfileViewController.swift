//
//  ProfileViewController.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 06/12/22.
//

import UIKit
import FirebaseAuth
import ProgressHUD

class ProfileViewController: UITableViewController {
    @IBOutlet weak var cellBackGroundView: UIView!
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var cityCountryLabel: UILabel!
    @IBOutlet weak var aboutMeView: UIView!
    
    @IBOutlet weak var NameAgeLabel: UILabel!
    
    @IBOutlet weak var aboutMeTxtView: UITextView!
    
    @IBOutlet weak var addJobTxtField: UITextField!
    
    @IBOutlet weak var AddEducationTxtField: UITextField!
    
    @IBOutlet weak var genderTxtField: UITextField!
    @IBOutlet weak var countryTxtField: UITextField!
    
    @IBOutlet weak var cityTextFIeld: UITextField!
    
    @IBOutlet weak var heightTxtField: UITextField!
    
    @IBOutlet weak var LookingFor: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         backgroundSetUp()
        
    }


    @IBAction func onCameraClick(_ sender: Any) {
        
        
        
    }
    
    @IBAction func onEditClick(_ sender: Any) {
        
        
    }
    
    @IBAction func onSettingsClick(_ sender: Any) {
        
        
    }
    
    
    //MARK:- BackgroundSetUp
    
    func backgroundSetUp(){
        cellBackGroundView.clipsToBounds = true
        cellBackGroundView.layer.cornerRadius = 100
        cellBackGroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        aboutMeView.layer.cornerRadius = 10
        self.title = "Profile"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updateProfileInfo))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage.init(systemName:"square.and.arrow.up.circle.fill"), style: .done, target: self, action: #selector(loggedOut))
        
        
    }
    
    //MARK:- TableView Delegate
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    //MARK:- Update Profile Info
    
    @objc func  updateProfileInfo(){
        //print("Save button pressed")
        
        guard let  aboutMeTxt = self.aboutMeTxtView.text, let addJobTxt = self.addJobTxtField.text, let addEducationTxt = self.AddEducationTxtField.text else {
            
            return
        }
        
        if aboutMeTxt == "" || addJobTxt == "" ||  addEducationTxt == "" {
            ProgressHUD.showError("Please enter any information right beofre you save anything")

        }
    }
    
    
    @objc func loggedOut(){
       
        let alert = UIAlertController(title:"Logged Out?", message:"Are you sure wants to logged out", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title:"OK", style: .default) { alert in
            do{
                try Auth.auth().signOut()
                self.popToRootViewController()
            }
            catch{
                print("Error while signing out!")
            }
        }
        
        let cancel = UIAlertAction(title:"Cancel", style: .default, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    
    func popToRootViewController(){
        self.dismiss(animated: false, completion: nil)
    }
    
    
}

