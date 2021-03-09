//
//  APIServiceTest.swift
//  RxFacebookMeTests
//
//  Created by Randy on 2021/03/09.
//

import XCTest
import RxSwift
import RxBlocking

class APIServiceTest: XCTestCase {

    func getCellInfoArray() -> [CellInfo] {
        struct Response : Decodable {
            var cellInfos : [RawCellInfo]
        }
        let jsonString =
            """
{
  "cellInfos":[
     {
        "section":0,
        "cellType":0,
        "imgName":"bayMax",
        "title":"BayMax",
        "detailTitle":"View Your Profile"
     },
     {
        "section":1,
        "cellType":1,
        "imgName":"fb_friends",
        "title":"Friends"
     },
     {
        "section":1,
        "cellType":1,
        "imgName":"fb_events",
        "title":"Events"
     },
     {
        "section":1,
        "cellType":1,
        "imgName":"fb_groups",
        "title":"Groups"
     },
     {
        "section":1,
        "cellType":1,
        "imgName":"fb_education",
        "title":"CMU"
     },
     {
        "section":1,
        "cellType":1,
        "imgName":"fb_town_hall",
        "title":"Town Hall"
     },
     {
        "section":1,
        "cellType":1,
        "imgName":"fb_games",
        "title":"Instant Games"
     },
     {
        "section":1,
        "cellType":2,
        "title":"See More..."
     },
     {
        "section":2,
        "cellType":2,
        "title":"Add Favorites..."
     },
     {
        "section":3,
        "cellType":1,
        "imgName":"fb_settings",
        "title":"Settings"
     },
     {
        "section":3,
        "cellType":1,
        "imgName":"fb_privacy_shortcuts",
        "title":"Privacy Shortcuts"
     },
     {
        "section":3,
        "cellType":1,
        "imgName":"fb_help_and_support",
        "title":"Help and Support"
     },
     {
        "section":4,
        "cellType":3,
        "title":"Log Out"
     }
  ]
}
"""
        do{
            let data = jsonString.data(using: .utf8)
            
            let rawCellInfoArray = try JSONDecoder().decode(Response.self, from: data!)
            
            let cellInfoArray = rawCellInfoArray.cellInfos.map({cell -> CellInfo in
                return CellInfo(id: UUID().uuidString, section: cell.section, cellType: CellType(rawValue: cell.cellType)!, imgName: cell.imgName, title: cell.title, detailTitle: cell.detailTitle)
            })
            return cellInfoArray
            
        }catch{
            return []
        }
    }
    
    override func setUp() {
        super.setUp()
        
        addUIInterruptionMonitor(withDescription: "systemAlertHandlerDescription"){ alert -> Bool in
            if alert.buttons["Allow"].exists {
                alert.buttons["Allow"].tap()
            }
            return true
        }
        
    }
    
    func testArrayCellInfo() {
        do{
            let cellArray : [CellInfo] = try APIService.shared.getDataFromURL().toBlocking().first()!
            
            XCTAssertEqual(cellArray, getCellInfoArray())
        }catch{
            return
        }
        
    }


}
