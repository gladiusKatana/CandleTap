/*🔥CandleTap_Shakepay💧*/import UIKit

func fetchShakepayFeedForUrlString(urlString: String, completion: @escaping ([ShakepayPriceUpdate]) -> ()) {
    //print("fetching shakepay\n")      //; print("shakepay url: \(urlString)")
    
    guard let youAreElle = URL(string: urlString) else {print("error binding shakepay url"); return}
    
    URLSession.shared.dataTask(with: youAreElle as URL) { (data, response, error) in
        guard let data = data else { print("error binding shakepay  data  parameter in URLSession")
            return}
        do {
            guard let jsonDictionaries =
                try [JSONSerialization.jsonObject(with: data, options: .mutableContainers)] as? [[String: AnyObject]] else {
                    print("error binding shakepay json-dictionaries to array (Shakepay API format)"); return
            }
            
            completion (
                jsonDictionaries.map(
                    {
                        return ShakepayPriceUpdate(dictionary: $0)
                    }
                )
            )
        } catch let jsonSerializationError {print("Error serializing json:", jsonSerializationError)}
        
    }
    .resume()
}

class ShakepayPriceUpdate: SafeJsonObject {
    @objc var BTC_CAD: Any?
    @objc var CAD_BTC: AnyObject?
    @objc var ETH_CAD: AnyObject?
    @objc var CAD_ETH: AnyObject?
    @objc var BTC_USD: AnyObject?
    @objc var USD_BTC: AnyObject?
    @objc var ETH_USD: AnyObject?
    @objc var USD_ETH: AnyObject?
    @objc var BTC_ETH: AnyObject?
    @objc var ETH_BTC: AnyObject?
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}

