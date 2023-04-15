//
//  ChatViewController.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 06/12/22.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "Conversations"
        self.setUpView()
    }
    
    func setUpView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

//MARK:- TableView Delegate Data Source method
extension ChatViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier:"ChatTableViewCell") as? ChatTableViewCell else {
            fatalError("Fatal error")
        }
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToMessageView()
    }
    
    
    func moveToMessageView(){
        guard let messageView = self.storyboard?.instantiateViewController(withIdentifier:"MessageViewController") as? MessageViewController else { return }
        messageView.modalPresentationStyle = .fullScreen
        self.present(messageView, animated: false, completion: nil)
    }
}
