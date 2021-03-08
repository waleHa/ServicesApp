//
//  ContactUsViewController.swift
//  Flash Chat iOS13
//
//  Created by admin on 2021-01-02.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController,MFMailComposeViewControllerDelegate
 {
    @IBOutlet weak var commentsBox: UITextField!
    @IBOutlet weak var subjectBox: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func callUSButton(_ sender: UIButton) {        
        Utilities.dialNumber(Constants.yohoInfo.phone)
        print("dialNumber")
    }
    
    
    
    @IBAction func sendEmailButton(_ sender: UIButton) {
        let mailComposeViewController = configureMailComposer()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailComposeViewController, animated: true, completion: nil)
            }else{
                print("Can't send email")
            }
        }
    func configureMailComposer() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients([Constants.yohoInfo.email])
        mailComposeVC.setSubject(self.subjectBox.text!)
        mailComposeVC.setMessageBody(self.commentsBox.text!, isHTML: false)
        return mailComposeVC
    }
    //MARK: - MFMail compose method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
//    if MFMailComposeViewController.canSendMail() {
//    let mail = MFMailComposeViewController()
//    mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
//    mail.setToRecipients(["abc@gmail.com","xyz@gmail.com"])
//    mail.setMessageBody(commentsBox.text ?? "<h1>Hello there, This is a test.<h1>", isHTML: true)
//    present(mail, animated: true)
//    } else {
//    print("Cannot send email")
//    }

    
    


    

}
