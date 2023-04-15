//
//  NotificationViewController.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 06/12/22.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Notifications"
        setupView()
        
    }
    
    func setupView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

}


//MARK:- TableView Delegate && Data Source
extension NotificationViewController:UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier:"NotificationCell") as? NotificationCell else {
            fatalError("Fatal error ...")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
