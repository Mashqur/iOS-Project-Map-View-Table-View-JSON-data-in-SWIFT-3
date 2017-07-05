
import UIKit
import MapKit


let BASE_URL = "http://www.codetalk.de/cars.json"
let CAR_IMAGE_URL = "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/modelIdentifier/color/2x/car.png"

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var allCarLocationMap: MKMapView!
    @IBOutlet weak var carList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        carList.dataSource = self
        CarDataController.loadCars { () -> () in
            self.showAllCar()
        }
    }
    
   //MARK: Table Cell Counter
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return CarDataController.getCars().count
    }
    //MARK: Table Cell Data Load
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let fetchedCarInfo = CarDataController.getCars()
        let cell = carList.dequeueReusableCell(withIdentifier: "cell") as! CarCell
        cell.ownerName.text = fetchedCarInfo[indexPath.row].carOwner
        cell.make.text = fetchedCarInfo[indexPath.row].carName
        cell.group.text = fetchedCarInfo[indexPath.row].carModel
        cell.color.text = fetchedCarInfo[indexPath.row].carColor
        cell.licenceNumber.text = fetchedCarInfo[indexPath.row].carNumberPlate
        let imgUrl = NSURL(string: fetchedCarInfo[indexPath.row].carImageUrl)
        //MARK: Fallback uesd for image
        cell.carImage.sd_setImage(with: imgUrl! as URL, placeholderImage: UIImage(named: "fit-car-smiley.png"))
        return cell
    
    }
    //MARK: Car Location Setup
    func showAllCar() {
        let CarLocationInfo = CarDataController.getCars()
        let location = CLLocationCoordinate2DMake(CarLocationInfo[0].carLat, CarLocationInfo[0].carLong)
        allCarLocationMap.setRegion(MKCoordinateRegionMakeWithDistance(location, 20000, 20000), animated: true)
        for carLocation in CarLocationInfo {
            let allcarLoacationMark = MKPointAnnotation()
            allcarLoacationMark.coordinate = CLLocationCoordinate2DMake(carLocation.carLat, carLocation.carLong)
            allcarLoacationMark.title = carLocation.carOwner
            allCarLocationMap.addAnnotation(allcarLoacationMark)
        }
        self.perform(#selector(self.reloadTableData), with: nil, afterDelay: 1.0);
    }
    //MARK: Table Load
    func reloadTableData() {
        self.carList.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

