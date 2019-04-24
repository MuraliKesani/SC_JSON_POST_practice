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
    
    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var batchIDLbl: UILabel!
    @IBOutlet weak var studentIDLbl: UILabel!
    @IBOutlet weak var regEmailLbl: UILabel!
    
    
    var urlREQ:URLRequest!
    var sessionDataTask:URLSessionDataTask!
    
    var detailsArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    
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
            do{
                var converterData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:String]
                print(converterData)
                DispatchQueue.main.async {
                    if(converterData["loggedIn"] == "no"){
                        
                        let alert = UIAlertController(title: "WARNING", message: "INVALID USERNAME/PASSWORD", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        self.detailsArray = [converterData["batchID"]!,converterData["studentID"]!,converterData["firstName"]!,converterData["surName"]!,converterData["registeredEmail"]!,converterData["profileImagePath"]!]
                        self.batchIDLbl.text = self.detailsArray[0]
                        self.studentIDLbl.text = self.detailsArray[1]
                        self.nameLbl.text = "\(self.detailsArray[3]) \(self.detailsArray[2])"
                        self.regEmailLbl.text = self.detailsArray[4]
                        
                        var imgURLString = self.detailsArray[5]
                        imgURLString = imgURLString.replacingOccurrences(of: "../uploads/", with: "")
                        
                        let url = NSURL(string: "https://www.brninfotech.com/pulse/modules/uploads/\(imgURLString)")
                        let data = NSData(contentsOf: url! as URL)
                        if(data != nil){
                            self.loginImage.image = UIImage(data: data! as Data)
                        }
                        }
                }
                
            }catch{
                print("something wrong")
            }
            
        })
        sessionDataTask.resume()
        
    }
    
    
    
}

