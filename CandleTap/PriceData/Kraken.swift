/*🔥CandleTap_Kraken💧*/import UIKit

func fetchKrakenFeedForUrlString(urlString: String, completion: @escaping ([KrakenApiResponse]) -> ()) {
    
    guard let url = URL(string: urlString) else {
        //print("error binding krk url")
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            //print("error binding krk  data  parameter in URLSession")
            return
        }
        
        do {
            guard let jsonDictionaries
                = try [JSONSerialization.jsonObject(with: data, options: .mutableContainers)] as? [[String: AnyObject]] else {
                    print("error converting krk json to array of dictionaries")
                    return
            }
            
            completion(jsonDictionaries.map({return KrakenApiResponse(dictionary: $0)}))
            
        } catch let error {
            print("Error serializing json:", error.localizedDescription)
        }
    }
    .resume()
}

class KrakenApiResponse: SafeJsonObject {
    @objc var error: [Any]?
    @objc var result: KrakenTradingPair?
    
    @objc override func setValue(_ value: Any?, forKey key: String) {
        guard key == "result" else {            /// custom result setup *
            super.setValue(value, forKey: key); return
        }
        result = KrakenTradingPair()
        result?.setValuesForKeys(value as! [String: AnyObject])
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}

class KrakenTradingPair: SafeJsonObject {
    @objc var XXBTZCAD: [[AnyObject]]?      //; @objc var XETHZXBT: [[AnyObject]]?  /// ; @objc var XXETHBTZ: [[AnyObject]]?
    @objc var XXBTZEUR: [[AnyObject]]?;     @objc var XXBTZUSD: [[AnyObject]]?
    @objc var last: AnyObject?              // cannot be : Date ... will have to convert to formatted date
}

