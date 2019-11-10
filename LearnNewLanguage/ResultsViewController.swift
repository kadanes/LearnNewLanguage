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
    var translatedText = ""
    let jsonEncoder = JSONEncoder()
    let translateURL = "https://unitec-assignment3-translation.cognitiveservices.azure.com/sts/v1.0/issuetoken"
    let translateKey = "7c0cc4fccb60499e8c4e767bdcf94539"

    @IBOutlet weak var translationLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        translate(toTranslate: imageResult ?? "error occured")
        self.resultLabel.text =  imageResult
        //  below line was not updating label move this to within the translate function instead for it to work
        //self.translationLabel.text = translatedText

        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func translate(toTranslate: String){
        let fromLangCode = "en"
        let toLangCode = "de"
            
           // print("this is the selected language code ->", arrayLangInfo[fromLangCode].code)
            
           // let selectedFromLangCode = arrayLangInfo[fromLangCode].code
            //let selectedToLangCode = arrayLangInfo[toLangCode].code
            
            struct encodeText: Codable {
                var text = String()
            }
            
            let azureKey = "7c0cc4fccb60499e8c4e767bdcf94539"
            
            let contentType = "application/json"
            let traceID = "A14C9DB9-0DED-48D7-8BBE-C517A1A8DBB0"
            let host = "dev.microsofttranslator.com"
            let apiURL = "https://dev.microsofttranslator.com/translate?api-version=3.0&from=" + fromLangCode + "&to=" + toLangCode
            
            let text2Translate = toTranslate
            var encodeTextSingle = encodeText()
            var toTranslate = [encodeText]()
            
        encodeTextSingle.text = text2Translate
            toTranslate.append(encodeTextSingle)
            
            let jsonToTranslate = try? jsonEncoder.encode(toTranslate)
            let url = URL(string: apiURL)
            var request = URLRequest(url: url!)

            request.httpMethod = "POST"
            request.addValue(azureKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
            request.addValue(traceID, forHTTPHeaderField: "X-ClientTraceID")
            request.addValue(host, forHTTPHeaderField: "Host")
            request.addValue(String(describing: jsonToTranslate?.count), forHTTPHeaderField: "Content-Length")
            request.httpBody = jsonToTranslate
            
            let config = URLSessionConfiguration.default
            let session =  URLSession(configuration: config)
            
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                
                if responseError != nil {
                    print("this is the error ", responseError!)
                    
                    let alert = UIAlertController(title: "Could not connect to service", message: "Please check your network connection and try again", preferredStyle: .actionSheet)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    
                    self.present(alert, animated: true)
                    
                }
                print("*****")
                self.parseJson(jsonData: responseData!)
            }
            task.resume()
        }
        
        
        func parseJson(jsonData: Data) {
            
            //*****TRANSLATION RETURNED DATA*****
            struct ReturnedJson: Codable {
                var translations: [TranslatedStrings]
            }
            struct TranslatedStrings: Codable {
                var text: String
                var to: String
            }
            
            let jsonDecoder = JSONDecoder()
            let langTranslations = try? jsonDecoder.decode(Array<ReturnedJson>.self, from: jsonData)
            let numberOfTranslations = langTranslations!.count - 1
            print(langTranslations!.count)
            
            //Put response on main thread to update UI
            DispatchQueue.main.async {
                print(self.translatedText)
                self.translatedText = langTranslations![0].translations[numberOfTranslations].text
                print(self.translatedText)
                self.translationLabel.text = self.translatedText
            }
        }
    
    
       
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


