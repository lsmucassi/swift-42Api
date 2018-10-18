//
//  ApiController.swift
//  42r00
//
//  Created by Linda MUCASSI on 2018/10/07.
//  Copyright © 2018 Linda MUCASSI. All rights reserved.
//

import Foundation
import UIKit

class ApiController: NSObject {
    
    var code: String = "code"
    let uid = "feaca4bc0a80a43c02c99c8e4997a955831f8e28c408fd7301bd457355b61894";
    let secret = "4c5c33331f09dc4cc2088753862a7f769aeb24cc34f83601a2b559e8c657f64e";
    //    let baseUrl = NSUrl(string: "https://api.intra.42.fr/");
    //    let BEARER = (())
    
    //    curl -F grant_type=authorization_code \
    //    -F client_id=2c4a23c4273fb5423b7f993442ab1d852d782fb723da4f88750983d5c7e377d4 \
    //    -F client_secret=429ee42e5619806f546ee7dae11ff285b1788caf6cb48a1e49a91cf434a6be74 \
    //    -F code=781101fa6e9416c9c4a786997f4b94fe888ffa80b9cf575bec84130406e76e9c \
    //    -F redirect_uri=https://profile.intra.42.fr/ \
    //    -X POST https://api.intra.42.fr/oauth/token
    
    func getAccessToken(){
        // prepare json data
        let json: [String: Any] = [
            "grant_type": "authorization_code",
            "client_id": "\(uid)",
            "client_secret": "\(secret)",
            "code": "\(code)",
            "redirect_uri": "https://profile.intra.42.fr/"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "https://api.intra.42.fr/oauth/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
}
