//
//  AppData.swift
//  Fenrir
//
//  Created by CooperHsu on 2020/8/26.
//  Copyright © 2020 CooperHsu. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class AppData: ObservableObject{
    @Published var url = "https://yiketianqi.com/api"
    @Published var showingAlert = false
    @Published var resp = ""
    @Published var postData = [
        "appid": "44491684",
        "appsecret": "tmz23T43",
        "version": "v6",
        "city": "朝阳"
    ]
}
extension AppData{
    func getData(_ url: String) -> Bool {
        let parameters: [String: String] = self.postData
        //        DispatchQueue.main.async {
        AF.request(url,
                   //                       method: .get,
            parameters: parameters,
            //                       encoder: JSONParameterEncoder.prettyPrinted
            requestModifier: { $0.timeoutInterval = 15 }
        )
            .validate(statusCode: 200..<300)
            .responseJSON{response in
                switch response.result {
                case .success(let JSON):
                    print("Success with JSON: \(JSON)")
                    let dict = JSON as! Dictionary<String,AnyObject>
                    let date = dict["date"] as! String
                    let city = dict["city"] as! String
                    let air_tips = dict["air_tips"] as! String
                    let tem = dict["tem"] as! String
                    self.resp = "日期: \(date)\n地区: \(city)\n温度: \(tem)\n天气: \(air_tips)\n"
                    self.showingAlert = false
                    debugPrint(response.metrics ?? "ahaha")
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    self.resp = "Request failed with error: \(error)"
                    self.showingAlert = true
                }
        }
        return self.showingAlert
    }
}
