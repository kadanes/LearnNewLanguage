//
//  ViewController.swift
//  LearnNewLanguage
//
//  Created by Swati Sharma on 15/10/19.
//  Copyright © 2019 Ankur Lakhanpal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var responseLabel: UILabel!
    var responseResult: String?
    
    var imagePicker: ImagePicker?
    
    let cognitivesServicesAPIKey = "0e05d1cd15f34e8d9baa2584f5311722"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Initialise image picker
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    // Handle button press
    @IBAction func showPicker(_ sender: UIButton) {
        imagePicker?.present()
        
        
        
    }
    
    @IBAction func analyzeImage(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    // Retrieve tags
    private func getTags(selectedImage: UIImage?) {
        guard let selectedImage = selectedImage else { return }
        
        // URL for cognitive services tag API
        guard let url = URL(string: "https://unitec-assignment-three.cognitiveservices.azure.com/vision/v2.0/describe") else { return }
        
        // API request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.setValue(cognitivesServicesAPIKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.httpBody = selectedImage.pngData()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else { return }
            print(response.statusCode) // console debugging comment out after
            if response.statusCode == 200 {
//                let responseString = String(data: data, encoding: .utf8)
                let describeImage = try? JSONDecoder().decode(DescribeImage.self, from: data)
                print(describeImage?.description?.captions?[0].text)
                     //console debugging to see if json returned/stored
                guard let captions = describeImage?.description?.captions else { return }
                DispatchQueue.main.async {
                    if captions.count > 0 {
                        //self.responseLabel.text = captions[0].name // returns error string to uilabel nil
                        self.responseResult = captions[0].text
                    } else {
                        self.responseLabel.text = "No captions available"
                    }
                    
                }
            } else {
                DispatchQueue.main.async {
                    self.responseLabel.text = error?.localizedDescription
                }
            }
        }
        // Resume task
        task.resume()
    }
}

extension ViewController: ImagePickerDelegate {
    
    // Delegate function
    func didSelectImage(image: UIImage?) {
        self.imageView.image = image
        getTags(selectedImage: image)
    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.imageResult = responseResult?.replacingOccurrences(of: "_", with: " ")
        }
        
        if segue.identifier == "goToHistory"{
            let destinantionVC = segue.destination as! HistoryViewController
        }
        
    }
    
   
    
}


