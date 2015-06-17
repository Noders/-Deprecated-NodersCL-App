//
//  ClaseUnoViewController.swift
//  StrongLoopForiOS
//
//  Created by Jose Vildosola on 13-05-15.
//  Copyright (c) 2015 DevIn. All rights reserved.
//

import UIKit

class ClaseUnoViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    var loader = SBAnimatedLoaderView()
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        let width = 150 as CGFloat
        let frame = CGRectMake((self.view.frame.width - width) / 2, (self.view.frame.height - width) / 2, width, width)
        let LoaderbackgroundColor = UIColor.darkGrayColor()        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
