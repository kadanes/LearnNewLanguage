//
//  HistoryViewController.swift
//  LearnNewLanguage
//
//  Created by Jayson Jury on 8/11/19.
//  Copyright © 2019 Ankur Lakhanpal. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    var searchHistory: [ResultItem]? = [ResultItem(resultDescription: "test 1 result",      translationDescription: "test 1 translation"),
                                        ResultItem(resultDescription: "test 2 result", translationDescription: "test 2 translation"),
                                        ResultItem(resultDescription: "test 3 result", translationDescription: "test 3 translation"),
                                        ResultItem(resultDescription: "test 4 result", translationDescription: "test 4 translation")] // test array, remove/ comment out before = once code auto updates history

    @IBAction func returnToMain(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // load items from the searchHistory array into the UI table.
        
        // Do any additional setup after loading the view.
    }
    
    struct ResultItem {
        var resultDescription: String?
        var translationDescription: String?
        //later can add a thumbnail here if find solution
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
