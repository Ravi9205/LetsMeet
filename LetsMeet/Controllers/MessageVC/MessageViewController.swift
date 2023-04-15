//
//  MessageViewController.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 12/12/22.
//

import UIKit

class MessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .systemRed
        
        self.title = "Message"
        
        
    }
    
    @IBAction func onClickBackButton(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    
    

}
