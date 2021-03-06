import Foundation

class BeerListRequest {
    let URL = NSURL(string: "https://pbandjson.herokuapp.com/beers.json")!
    
    func perform(callback:(list:[Beer], error:NSError?) -> Void) {
        var retrieved:[Beer] = []
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(URL) {
            (data, response, error) in
            
            if error != nil {
                callback(list: [], error: error)
                return
            }
            
            var parseError: NSError? = nil
            let jsonObject:AnyObject?
            do {
                jsonObject = try NSJSONSerialization.JSONObjectWithData(data!,
                                options: NSJSONReadingOptions(rawValue: 0))
            } catch let error as NSError {
                parseError = error
                jsonObject = nil
            } catch {
                fatalError()
            }
            
            if parseError != nil {
                print("JSON Error: \(parseError)")
                callback(list: [], error: error)
                return
            }
            
            print("\(jsonObject)")
            
            if let beers = jsonObject as? [[String:AnyObject]] {
                for beerJSON in beers {
                    retrieved.append(Beer.fromJSON(beerJSON))
                }
                
                retrieved.sortInPlace { $0.name < $1.name }
                
                callback(list: retrieved, error: nil)
            }
            
            
        }
        
        task.resume()
    }
}