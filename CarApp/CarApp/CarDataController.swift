

class CarDataController {
    //MARK: Variable Declaration
    static var carsArray = [CACar]()
    //MARK: Access static vaiable
    class func getCars() -> [CACar] {
        return carsArray
    }
    
    class func addCar(car:CACar) {
        CarDataController.carsArray.append(car)
    }
    //MARK: Web service call
    class func loadCars(handleComplete:@escaping (()->())){
        let url = URL(string: BASE_URL)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: url!) { (data, response, error) in
            if (error != nil) {
                print("Error")
            } else {
                do {
                    let fetchCarData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                    print(fetchCarData)
                    
                    for eachCarData in fetchCarData {
                        let eachCar = eachCarData as! [String: Any]
                        let owner = eachCar["name"] as! String
                        let carMake = eachCar["make"] as! String
                        let carGroup = eachCar["group"] as! String
                        let carNumber = eachCar["licensePlate"] as! String
                        let color = eachCar["color"] as! String
                        let carLat = eachCar["latitude"] as! Double
                        let carLong = eachCar["longitude"] as! Double
                        let imageIdentifier = eachCar["modelIdentifier"] as! String
                        
                        var carImageUrl = CAR_IMAGE_URL;
                        carImageUrl = carImageUrl.replacingOccurrences(of: "modelIdentifier", with:imageIdentifier, options: .literal, range: nil)
                        carImageUrl = carImageUrl.replacingOccurrences(of: "color", with:color, options: .literal, range: nil)
                        addCar(car: CACar(carOwner: owner, carName: carMake, carModel: carGroup, carNumberPlate: carNumber, carColor: color, carImage: carImageUrl, carLat: carLat, carLong: carLong))
                    }
                    handleComplete()
                }
                catch {
                    print("error2")
                }
            }
        }
        task.resume()
    }
}
