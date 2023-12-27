//
//  ViewController.swift
//  URLSession project
//
//  Created by Macbook Air 2017 on 26. 12. 2023..
//

import UIKit

let GET_ENDPOINT = "https://jsonplaceholder.typicode.com/users"
let POST_ENDPOINT = "https://jsonplaceholder.typicode.com/posts"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getTapped(_ sender: Any) {
        
        // Create URL
        guard let url = URL(string: GET_ENDPOINT) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print("Error occured.")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response Status code: \(response.statusCode)\n")
            }
            
            // Converting json data into eye-readable data
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    print(json)
                }
                catch {
                    print("Was not able to convert data.")
                    return
                }
            }
        })
        task.resume()
    }

    @IBAction func postTapped(_ sender: Any) {
        
        // Create URL
        guard let url = URL(string: POST_ENDPOINT) else {
            return
        }
        
        // Create URL Request
        var urlRequest = URLRequest(url: url)
        
        // Specify HTTP Method
        urlRequest.httpMethod = "POST"
        
        // Set HTTP Request Header
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Specify parameters
        let parameters = [
            "username": "billy_who",
            "tweet": "HelloWorld"
        ]
        
        // Turning parameters into JSON
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters) else {
            return
        }
        
        // Setting HTTP Request httpBody (request message)
        urlRequest.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print("Error occured.")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response Status code: \(response.statusCode)\n")
            }
            
            // Converting json data into eye-readable data
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    print(json)
                }
                catch {
                    print("Was not able to convert data.")
                    return
                }
            }
        })
        task.resume()
    }
}

