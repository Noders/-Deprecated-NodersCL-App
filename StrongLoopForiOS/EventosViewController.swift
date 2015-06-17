//
//  EventosViewController.swift
//  Noders
//
//  Created by Jose Vildosola on 22-05-15.
//  Copyright (c) 2015 DevIn. All rights reserved.
//

import UIKit
import MBProgressHUD
import SpinKit
import SIAlertView


class EventosViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var eventosTableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var dataLoaded = false
    var hud: MBProgressHUD?
    var eventosArray:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventosTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.eventosTableView.delegate = self
        self.eventosTableView.dataSource = self
        self.eventosTableView.registerClass(EventoTableViewCell.self, forCellReuseIdentifier: "cell")
        self.eventosTableView.registerNib(UINib(nibName: "EventoCellView", bundle: nil), forCellReuseIdentifier: "cell")        
        
        let adapter = (UIApplication.sharedApplication().delegate as! AppDelegate).adapter
        let eventosRepo = adapter?.repositoryWithClass(EventoRepository.self) as! EventoRepository
        let spinner:RTSpinKitView = RTSpinKitView(style: RTSpinKitViewStyle.Style9CubeGrid)
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud!.labelText = "Cargando"
        hud!.mode = MBProgressHUDMode.CustomView
        hud!.customView = spinner
        
        eventosRepo.allWithSuccess({ (results) -> Void in
            self.eventosArray = results
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.eventosTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.dataLoaded = true
                self.numberOfSectionsInTableView(self.eventosTableView)
                self.eventosTableView.reloadData();
                self.eventosTableView.tableFooterView = UIView(frame: CGRectZero)
            })
        }, failure: { (error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.hud!.hide(true)
                let alert:SCLAlertView = SCLAlertView()
                alert.showError("Eventos", subTitle: "Hubo un error al recuperar la lista de eventos", closeButtonTitle: "Aceptar", duration: 0.0)
            })
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! EventoTableViewCell
        var evento = eventosArray.objectAtIndex(indexPath.row) as! EventoModel
        cell.eventoTitle.text = evento.name
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let eventDate = formatter.dateFromString(evento.fechainicio)
        formatter.dateFormat = "EEEE d 'de' MMMM 'de' yyyy"
        cell.eventoDate.text = formatter.stringFromDate(eventDate!)
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.layoutMargins = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if dataLoaded {
            return 1;
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventosArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95;
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
