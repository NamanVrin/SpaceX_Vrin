//
//  ViewController.swift
//  SpaceX
//
//  Created by HimAnshu on 18/10/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Variable &  @IBOutlet define
    var arrData = NSMutableArray()
    var arrTemp = NSArray()
    var seletedMission = NSMutableString()
    @IBOutlet weak var tblView: UITableView!
    
    //MARK:- Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.isHidden = true
        getAllData()
    }
    //MARK:- Api Call
    func getAllData () {
        
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "d5f23b83-ff33-7370-8fdb-6b3f3fd0e34d"
        ]
        let strUrl = "https://api.spacexdata.com/v3/capsules"
        let request = NSMutableURLRequest(url: NSURL(string: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 50)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
               
            } else {
                
                do{
                    let jsonData : NSArray = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                    
                    print(jsonData)
                    for i in 0 ..< jsonData.count {
                        
                        if let strLaunch = (jsonData[i] as? NSDictionary)?.value(forKey:"original_launch") as? String{
                            let strYear = self.yearconvertDateFormater(strLaunch)
                            print(strYear)
                            let year = (Int)(strYear)
                            if  year! >= 2014{
                                self.arrData.add(jsonData[i])
                            }
                            
                        } else {
                            
                        }
                    }
                    print(self.arrData)
                    if self.arrData.count > 0 {
                        self.tblView.isHidden = false
                        self.tblView.dataSource = self
                        self.self.tblView.delegate = self
                        self.tblView.reloadData()
                    } else  {
                        self.tblView.isHidden = true
                    }
                  
                    
                } catch {
                    print(error as AnyObject)
                   
                }
            }
        })
        
        dataTask.resume()
    }
    
    //MARK:- string Text color change method
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
    //MARK:- Date Convert Method
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)
        
    }
    

}
//MARK:-UITableViewDelegate & UITableViewDataSource
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arrData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SpaceTableViewCell") as? SpaceTableViewCell
        if cell == nil {
            tableView.register(UINib(nibName: "SpaceTableViewCell", bundle: nil), forCellReuseIdentifier: "SpaceTableViewCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "SpaceTableViewCell") as? SpaceTableViewCell
        }
        cell?.selectionStyle = .none
        if ((arrData[indexPath.row] as? NSDictionary)?.value(forKey:"original_launch") as? String) != nil{
            let str = convertDateFormater(((arrData[indexPath.row] as? NSDictionary)?.value(forKey:"original_launch") as? String)!)
            print(str)
             cell?.lblDate.attributedText =
                self.setAttributedStringWithBLueColor(str: String(format: "Date of launch:-  %@", str))
        } else  {
             cell?.lblDate.attributedText =
                self.setAttributedStringWithBLueColor(str: String(format: "Date of launch:-  %@" , ""))
        }
        if let strLanding = (arrData[indexPath.row] as? NSDictionary)?.value(forKey:"landings") as? NSNumber{
            
            cell?.lblLanding.attributedText =   self.setAttributedStringWithBLueColor(str: String(format: "Number of landing:-  %@",strLanding ))
        } else  {
           cell?.lblLanding.attributedText =   self.setAttributedStringWithBLueColor(str: String(format: "Number of landing:-  %@","" ))
        }
        
         
        cell?.lblType.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "Type:-  %@", "\(((self.arrData[indexPath.row] as! NSDictionary).value(forKey: "type") as! String))"))
        
        if (((arrData[indexPath.row] as? NSDictionary)?.value(forKey: "missions") as? NSArray)?.count)! > 0 {
            
            arrTemp = NSArray()
            arrTemp = (((arrData[indexPath.row] as? NSDictionary)?.value(forKey: "missions") as? NSArray))!
            self.seletedMission = NSMutableString()
            for i in stride(from: 0, to: self.arrTemp.count, by: 1){
                let strName =  ((arrTemp.object(at: i) as? NSDictionary)?.value(forKey: "name") as? String)
                self.seletedMission.append(strName!)
                self.seletedMission.append(",")
            }
            
            if self.seletedMission.length > 0 {
                
                let range = NSRange(location: self.seletedMission.length - 1, length: 1)
                self.seletedMission.replaceCharacters(in: range, with: "")
            }
            print("\(self.seletedMission)")
            
            
             cell?.lblName.attributedText = self.setAttributedStringWithBLueColor(str: String(format: "Mission:-  %@",seletedMission ))
            
        } else {
             cell?.lblName.attributedText = self.setAttributedStringWithBLueColor(str: String(format: "Mission:- %@", ""))
        }
        
        if let  strDetail = ((self.arrData[indexPath.row] as? NSDictionary)?.value(forKey: "details") as? String) {
            print(strDetail)
            cell?.lblDetail.attributedText =  self.setAttributedStringWithBLueColor(str: String(format: "Details:-  %@",((self.arrData[indexPath.row] as? NSDictionary)?.value(forKey: "details") as? String)! ))
           
        } else  {
             cell?.lblDetail.text = ""
        }
        cell?.lblStatus.attributedText = self.setAttributedStringWithBLueColor(str: String(format: "Status:-  %@", ((self.arrData[indexPath.row] as! NSDictionary).value(forKey: "status") as? String)!))
        
        return cell!
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LaunchingDetailsVC") as! LaunchingDetailsVC
        vc.dictData = self.arrData[indexPath.row] as! NSDictionary
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
   
    
    //MARK:- Date Convert year Method
    func yearconvertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy"
        return  dateFormatter.string(from: date!)
        
    }


}

