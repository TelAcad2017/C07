//
//  ViewController.swift
//  20012018A
//
//  Created by bla on 1/20/18.
//  Copyright © 2018 bla. All rights reserved.
//

import UIKit

extension String : Error {}

class ViewController: UIViewController {

    // MARK: enum for expected errors
    enum ExpectedError : Error {
        case FirstError
        case FileNotFound
        case IllegalOperation
        case UnknownError
        
        func description() -> String {
            switch self {
            case .FirstError:
                return "First Error"
            case .FileNotFound:
                return "File Not Found"
            case .IllegalOperation:
                return "Illegal Operation"
            default:
                return "Unknown Error"
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        do {
            let path = try fetchJSONToString()
            print(path)
        } catch {
            print("Path not available")
        }
        
    }
    
    func fetchJSONToString() throws -> String
    {
        var defaultJsonObject: NSData? = nil
        
        do {
            // TAKE JSON FROM FILE
            // FILE PATH
            let path = try getPathFromBundle(fileName: "items", fileType: "json")
            // FILE CONTENT TO STRING
            do {
                let content = try String(contentsOfFile: path)
                let data = content.data(using: .utf8)
                // SERIALIZE TO JSON
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    
                    return String(describing: jsonObject)
                } catch let error {
                    print("Error while reading data from JSON : \(error.localizedDescription) . This is not good!")
                }
            } catch {}
        } catch let error{
            // CUSTOM ERROR
            let expectedError = error as! ExpectedError
            print(expectedError.description())
            
            // JSON FROM MEMORY
            // create default array
            let rawData: [[String: String]] = [[
                "id": "0",
                "name": "",
                "optional": "false"
            ],[
            "id": "0",
            "name": "",
            "optional": "false"
            ]]
            

            if let data = try? JSONSerialization.data(withJSONObject: rawData, options: JSONSerialization.WritingOptions(rawValue: 0)) {
                
                let objectString = String(data: data, encoding: .utf8)
                
                let newdata = objectString?.data(using: .utf8)
                
                if let jsonObject = try? JSONSerialization.jsonObject(with: newdata!, options: .mutableContainers)
                {
                    return String(describing: jsonObject)
                }
            }
        }
        
        return String(describing: defaultJsonObject)
    }
    
    func getPathFromBundle(fileName : String, fileType : String) throws -> String
    {
        let path = Bundle.main.path(forResource: fileName, ofType: fileType)
        
        if path == nil
        {
            throw ExpectedError.FileNotFound
        }
        
        return path!
    }
}
