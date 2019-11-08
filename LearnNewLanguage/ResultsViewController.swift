//
//  ResultsViewController.swift
//  LearnNewLanguage
//
//  Created by Jayson Jury on 8/11/19.
//  Copyright © 2019 Ankur Lakhanpal. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var imageResult: String?

  
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultLabel.text = imageResult

        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
