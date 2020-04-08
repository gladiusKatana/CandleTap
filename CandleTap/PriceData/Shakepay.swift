/*🔥CandleTap_Shakepay💧*/import UIKit

func fetchShakepayFeedForUrlString(urlString: String, completion: @escaping ([ShakepayApiResponse]) -> ()) {
    
    guard let url = URL(string: urlString) else {print("error binding shk url"); return}
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else { print("error binding shk  data  parameter in URLSession"); return}
        
        do {
            guard let jsonDictionaries
                = try [JSONSerialization.jsonObject(with: data, options: .mutableContainers)] as? [[String: AnyObject]] else {
                    print("error converting shk json to array of dictionaries"); return
            }
            
            completion(jsonDictionaries.map({return ShakepayApiResponse(dictionary: $0)}))
            
        } catch let error {
            print("Error serializing json:", error.localizedDescription)
        }
    }
    .resume()
}


class ShakepayApiResponse: SafeJsonObject {
    @objc var BTC_USD: AnyObject?
    @objc var USD_BTC: AnyObject?
    
    @objc var BTC_CAD: AnyObject?
    @objc var CAD_BTC: AnyObject?
    
    
    @objc var ETH_BTC: AnyObject?
    @objc var BTC_ETH: AnyObject?
    
    
    @objc var ETH_USD: AnyObject?
    @objc var USD_ETH: AnyObject?
    
    @objc var ETH_CAD: AnyObject?
    @objc var CAD_ETH: AnyObject?
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}

