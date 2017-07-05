
import UIKit

class CACar: NSObject {
    var carOwner : String
    var carName : String
    var carModel : String
    var carNumberPlate : String
    var carColor : String
    var carImageUrl : String
    var carLat : Double
    var carLong : Double
    
    init(carOwner : String, carName : String, carModel: String, carNumberPlate: String, carColor: String, carImage: String, carLat: Double, carLong: Double) {
        self.carOwner = carOwner
        self.carName = carName
        self.carModel = carModel
        self.carNumberPlate = carNumberPlate
        self.carColor = carColor
        self.carImageUrl = carImage
        self.carLat = carLat
        self.carLong = carLong
    }
}
