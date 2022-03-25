//
//  MainController.swift
//  BitcoinActPrice
//
//  Created by dan4 on 25.03.2022.
//

import Foundation
import Alamofire

final class ViewModel: ObservableObject {
    @Published var data: QuoteData?
    @Published var chart: [Double] = []
    var appendedItem: String = ""
    
    func updateData() {
        
        let request = AF.request("https://api.coindesk.com/v1/bpi/currentprice.json")
        
        request.responseDecodable(of: QuoteData.self) { (response) in
            
            guard let finalData = response.value else { return }
            
            DispatchQueue.main.async {
                self.data = finalData
            }
            
            self.appendedItem = String(((finalData.bpi.usd.rate.split(separator: ".")).first)!).replacingOccurrences(of: ",", with: "")
            
            if (self.chart.last != Double(self.appendedItem)!){
                self.chart.append(Double(self.appendedItem)!)
            }
            
            print(self.chart)
            print(finalData.bpi.usd.rate)
        }
    }

}
