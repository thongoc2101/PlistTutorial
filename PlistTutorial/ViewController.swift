//
//  ViewController.swift
//  PlistTutorial
//
//  Created by Phan Thi Ngoc Cam on 5/11/17.
//  Copyright © 2017 ngoccam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var giatri: UITextField!
    
    let myItemKey = "myItem"
    var myItemValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("list.plist")
        
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: path)) {
            if let bundlePath = Bundle.main.path(forResource: "list", ofType: "plist") {
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle File list.plist is: -> \(String(describing: result?.description))")
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                } catch {
                    print("Copy failure")
                }
            } else {
                print("File list.plist khong ton tai")
            }
        } else {
            print("File list.plist vua moi path")
        }
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("Load list.plist is -> \(String(describing: resultDictionary?.description))")
        
        let myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict {
            myItemValue = dict.object(forKey: myItemKey) as? String
            giatri.text = myItemValue
        } else {
            print("Load Failure")
        }
    }
}

