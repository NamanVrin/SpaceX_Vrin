//
//  LaunchingDetailsVC.swift
//  SpaceX
//
//  Created by HimAnshu on 18/10/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import UIKit

class LaunchingDetailsVC: UIViewController {
    
    //MARK:-  @IBOutlet  & Variable define
    @IBOutlet weak var lblFirstFlight: UILabel!
    @IBOutlet weak var lblMass: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblFuelUsed: UILabel!
    @IBOutlet weak var lblCrewCapacity: UILabel!
    @IBOutlet weak var lblNoOfThruster: UILabel!
    
    var dictData = NSDictionary()
    var arrTemp = NSArray()
    var arrTemp1 = NSArray()
    var seletedName = NSMutableString()
    var selectedFlight = NSMutableString()
    
    //MARK:- Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
         setupNavigationBar()
        setUIData()
      
    }
    //MARK:- SetUIData Method
    func setUIData(){
        
        if ((dictData.value(forKey: "missions") as? NSArray)?.count)! > 0 {
            
            arrTemp = NSArray()
            arrTemp = ((dictData.value(forKey: "missions") as? NSArray))!
            self.seletedName = NSMutableString()
            for i in stride(from: 0, to: self.arrTemp.count, by: 1){
                let strName =  ((arrTemp.object(at: i) as? NSDictionary)?.value(forKey: "name") as? String)
                self.seletedName.append(strName!)
                self.seletedName.append(",")
            }
            
            if self.seletedName.length > 0 {
                
                let range = NSRange(location: self.seletedName.length - 1, length: 1)
                self.seletedName.replaceCharacters(in: range, with: "")
            }
            print("\(self.seletedName)")
            
            
            lblname.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "Missions %@%@"," :- ",seletedName ))
            
        } else {
            lblname.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "Missions %@%@"," :- ","" ))
        }
        
        if ((dictData.value(forKey: "missions") as? NSArray)?.count)! > 0 {
            
            arrTemp1 = NSArray()
            arrTemp1 = ((dictData.value(forKey: "missions") as? NSArray))!
            self.selectedFlight = NSMutableString()
            for i in stride(from: 0, to: self.arrTemp1.count, by: 1){
                let strName1 =  ((arrTemp1.object(at: i) as? NSDictionary)?.value(forKey: "flight") as? NSNumber)
                let str = String(format: "%@", strName1!)
                self.selectedFlight.append(str)
                self.selectedFlight.append(",")
            }
            
            if self.selectedFlight.length > 0 {
                
                let range = NSRange(location: self.selectedFlight.length - 1, length: 1)
                self.selectedFlight.replaceCharacters(in: range, with: "")
            }
            print("\(self.selectedFlight)")
            
            
            lblFirstFlight.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "First flight %@%@"," :- ",selectedFlight ))
            
        } else {
            lblFirstFlight.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "First flight %@%@"," :- ", "" ))
        }
        
        lblMass.attributedText = self.setAttributedStringWithBLueColor(str: String(format: "Mass in lb: %@", "-"))
        lblFuelUsed.attributedText = self.setAttributedStringWithBLueColor(str: String(format: "Fuel Used: %@", "-"))
        lblCrewCapacity.attributedText = self.setAttributedStringWithBLueColor(str: String(format: "Crew Capacity: %@", "-"))
        
        lblNoOfThruster.attributedText = self.setAttributedStringWithBLueColor(str: String(format: "Number of Thruster: %@", "-"))
        
    }
    
    //MARK:- navigationBar
    func setupNavigationBar (){
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.blue
        self.navigationController?.navigationBar.barStyle = UIBarStyle(rawValue: 1)!
        self.navigationItem.title = "Launch Details"
        self.navigationController?.navigationBar.tintColor = UIColor.white
       
        let btnleft = UIBarButtonItem.init(image: #imageLiteral(resourceName: "back.png"), style: .plain, target: self, action: #selector(actionBack))
        self.navigationItem.leftBarButtonItem = btnleft
        
    }
    
    //MARK:- Button Action
    @objc func actionBack() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Text color change
    func setAttributedStringWithBLueColor(str:String) -> NSAttributedString {
        var strCheck = str
        
        var arr = str.components(separatedBy: " : ")
        
        if arr.count != 2 {
            strCheck = str.replacingOccurrences(of: ": ", with: ":")
            strCheck = str.replacingOccurrences(of: " :", with: ":")
            arr = strCheck.components(separatedBy: ":")
            
        }
        
        let attString = NSMutableAttributedString.init(string: String.init(format: "%@", arr[0]))
        
        attString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black , range: NSMakeRange(0, attString.length))
        
        
        let attString1 = NSMutableAttributedString.init(string: String.init(format: "%@", arr[1]))
        
        attString1.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.init(red: 34.0/255.0, green: 118.0/255.0, blue: 188.0/255.0, alpha: 1.0), range: NSMakeRange(0, attString1.length))
        
        attString.append(attString1)
        
        return attString
        
        
    }

}
