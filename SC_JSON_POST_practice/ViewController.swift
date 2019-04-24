//
//  ViewController.swift
//  SC_JSON_POST_practice
//
//  Created by Murali on 4/24/19.
//  Copyright © 2019 Murali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBTN: UIButton!
    
    var urlREQ:URLRequest!
    var sessionDataTask:URLSessionDataTask!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTF.text = "kesani.murali@gmail.com"
        passwordTF.text = "munna341820"
        
    }

    @IBAction func onLoginBTNTap(_ sender: UIButton)
    {
        
        urlREQ = URLRequest(url: URL(string: "https://www.brninfotech.com/pulse/modules/admin/ValidateLogin.php")!)
        urlREQ.httpMethod = "POST"
        
        let dataToSend = "registeredEmail=\(self.emailTF.text!)&registeredPassword=\(self.passwordTF.text!)&funcName=verifyLogin"
        
        urlREQ.httpBody = dataToSend.data(using: String.Encoding.utf8)
        
        sessionDataTask = URLSession.shared.dataTask(with: urlREQ, completionHandler: { (data, response, err) in
            
            print(data!)
            print("Got Response")
          
            
        })
        sessionDataTask.resume()
        
    }
    
    
    
}

