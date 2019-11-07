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
    
    var imagePicker: ImagePicker?
    
    let cognitivesServicesAPIKey = "1cb21888a87e4b538762c18e3e48fd26"
    let cognitivesServicesAPIKey2 = "791e2c680cdc41b197be2fcdd929e4c1"
    
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
    
    
    // Retrieve tags
    private func getTags(selectedImage: UIImage?) {
        guard let selectedImage = selectedImage else { return }
        
        // URL for cognitive services tag API
        guard let url = URL(string: "https://westcentralus.api.cognitive.microsoft.com/vision") else { return }
        
        // API request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.setValue(cognitivesServicesAPIKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.httpBody = selectedImage.pngData()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
//                let responseString = String(data: data, encoding: .utf8)
                let describeImage = try? JSONDecoder().decode(DescribeImage.self, from: data)
                guard let captions = describeImage?.description?.captions else { return }
                DispatchQueue.main.async {
                    if captions.count > 0 {
                        self.responseLabel.text = captions[0].text
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
}


