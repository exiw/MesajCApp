//
//  IkinciViewController.swift
//  CApp
//
//  Created by Emre Konukpay on 5.02.2023.
//

import UIKit

class IkinciViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    var notificationModel : NotificationModel?
    var zil = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        notificationModel = getNotifications()
        
    }
    
    
    
    func getNotifications() -> NotificationModel? {
        if let url = Bundle.main.url(forResource: "response", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode(NotificationModel.self, from: data)
                
                //print(jsonData)
                
                return jsonData
            } catch {
                print("error:(error)")
            }
        }
        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // = notificationModel?.notifications?.count ?? 0
        return notificationModel?.notifications?.count ?? 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsCell
        cell.titleLabel.text = notificationModel?.notifications?[indexPath.row].ntfTitle
        cell.storyLabel.text = notificationModel?.notifications?[indexPath.row].ntfContent
        cell.dateLabel.text = notificationModel?.notifications?[indexPath.row].ntfSendDatetime
        cell.userLabel.text = notificationModel?.notifications?[indexPath.row].senderUserType == "SYSTEM_ADMIN" ? "Admin" : notificationModel?.notifications?[indexPath.row].senderUserType
        cell.okuLabel.text = notificationModel?.notifications?[indexPath.row].ntfdReadDatetime == nil ? "Yeni Bildirim" : "Okundu"
        cell.backColor.backgroundColor = notificationModel?.notifications?[indexPath.row].ntfdReadDatetime == nil ? UIColor.green : UIColor.white
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
