import Foundation

class Productivity: NSObject {
    
    class var sharedInstance:Productivity {
        struct Static {
            static let instance = Productivity()
        }
        return Static.instance
    }
    
    func productivityCalculator() -> Array<Int> {
        
        var productivity:[Int] = [Int](count: 20000, repeatedValue: 0)
        
        productivity[10000] = 10000
        productivity[9999] = 7809
        productivity[9998] = 7809
        productivity[9997] = 23809
        productivity[9996] = 27809
        productivity[9995] = 17809
        productivity[9994] = 27809

        return productivity
    }
}
