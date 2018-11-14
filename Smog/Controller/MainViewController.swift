//
//  ViewController.swift
//  Smog
//
//  Created by Barbara Siczek on 14.01.2018.
//  Copyright © 2018 Barbara Siczek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController {

    @IBOutlet weak var airCondition: UILabel!
    
    let indexLevelURL = "http://api.gios.gov.pl/pjp-api/rest/aqindex/getIndex/129"
    
    let airConditionDataModel = AirConditionDataModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        getAirData(url : indexLevelURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

        //MARK: - Networking
    
    func getAirData(url: String){
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if response.result.isSuccess {
                print("Connection Success. Got the Air conditions data")
                let airJSON : JSON = JSON(response.result.value!)
                //print(airJSON)
                self.updateAirData(json: airJSON)
            }else{
                if let connectionError = response.result.error {
                    print("Error \(connectionError)")
                }
                self.airCondition.text = "Connection Issues"
            }
        }
    }
    
    //MARK: - JSON Parsing
    
    func updateAirData(json : JSON){
       if let airResult = json["stIndexLevel"]["indexLevelName"].string {
        
            airConditionDataModel.condition = airResult
            airCondition.text = airConditionDataModel.condition
        
        } else{
            airCondition.text = "Data Unavalible"
        }
        
    }


}

