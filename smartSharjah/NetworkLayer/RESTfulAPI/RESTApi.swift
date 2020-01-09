//
//  RESTApi.swift
//  smartSharjah
//
//  Created by Usman on 31/10/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import Foundation
import Moya


enum RESTApi {
    case authenticate(email: String, password: String)
    case arcGIS(lat: String, lng: String)
}

extension RESTApi: TargetType, AccessTokenAuthorizable{
    var baseURL: URL {
        switch self {
            
        case .arcGIS(let lat, let lng):
            return URL(string: "https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/findAddressCandidates?f=json&category=Landmark,Live%20Music,Museum,Other%20Arts%20and%20Entertainment,Performing%20Arts,Ruin,Science%20Museum,Tourist%20Attraction,Wild%20Animal%20Park,Zoo,Fine%20Arts%20School,Other%20Education,School,Vocational%20School,American%20Food,Argentinean%20Food,Australian%20Food,Austrian%20Food,Bakery,Balkan%20Food,BBQ%20and%20Southern%20Food,Belgian%20Food,Bistro,Brazilian%20Food,Breakfast,Brewpub,British%20Isles%20Food,Burgers,Cajun%20and%20Creole%20Food,Californian%20Food,Caribbean%20Food,Chicken%20Restaurant,Chilean%20Food,Chinese%20Food,Coffee%20Shop,Continental%20Food,Creperie,East%20European%20Food,Fast%20Food,Filipino%20Food,Fondue,French%20Food,Fusion%20Food,German%20Food,Greek%20Food,Grill,Hawaiian%20Food,Ice%20Cream%20Shop,Indian%20Food,Indonesian%20Food,International%20Food,Irish%20Food,Italian%20Food,Japanese%20Food,Korean%20Food,Kosher%20Food,Latin%20American%20Food,Malaysian%20Food,Mexican%20Food,Middle%20Eastern%20Food,Moroccan%20Food,Other%20Restaurant,Pastries,Pizza,Polish%20Food,Portuguese%20Food,Russian%20Food,Sandwich%20Shop,Scandinavian%20Food,Seafood,Snacks,South%20American%20Food,Southeast%20Asian%20Food,Southwestern%20Food,Spanish%20Food,Steak%20House,Sushi,Swiss%20Food,Tapas,Thai%20Food,Turkish%20Food,Vegetarian%20Food,Vietnamese%20Food,Winery,Basin,Butte,Canyon,Cape,Cave,Cliff,Desert,Dune,Flat,Forest,Glacier,Grassland,Hill,Island,Isthmus,Lava,Marsh,Meadow,Mesa,Mountain,Mountain%20Range,Oasis,Other%20Land%20Feature,Peninsula,Plain,Plateau,Point,Ravine,Ridge,Rock,Scrubland,Swamp,Valley,Volcano,Wetland,Dancing,Karaoke,Night%20Club,Nightlife,Beach,Campground,Diving%20Center,Fishing,Garden,Golf%20Course,Golf%20Driving%20Range,Harbor,Hockey,Ice%20Skating%20Rink,Nature%20Reserve,Other%20Parks%20and%20Outdoors,Park,Racetrack,Scenic%20Overlook,Shooting%20Range,Ski%20Lift,Ski%20Resort,Soccer,Sports%20Center,Sports%20Field,Swimming%20Pool,Tennis%20Court,Trail,Wildlife%20Reserve,Banquet%20Hall,Border%20Crossing,Building,Business%20Facility,Cemetery,Church,City%20Hall,Civic%20Center,Convention%20Center,Court%20House,Dentist,Doctor,Embassy,Factory,Farm,Fire%20Station,Government%20Office,Gurdwara,Hospital,Industrial%20Zone,Library,Livestock,Medical%20Clinic,Military%20Base,Mine,Mosque,Observatory,Oil%20Facility,Orchard,Other%20Professional%20Place,Other%20Religious%20Place,Place%20of%20Worship,Plantation,Police%20Station,Post%20Office,Power%20Station,Prison,Public%20Restroom,Radio%20Station,Ranch,Recreation%20Facility,Religious%20Center,Scientific%20Research,Shrine,Storage,Synagogue,Telecom,Temple,Tower,Veterinarian,Vineyard,Warehouse,Water%20Tank,Water%20Treatment,House,Nursing%20Home,Residential%20Area,Auto%20Dealership,Auto%20Maintenance,Auto%20Parts,Bank,Bookstore,Butcher,Candy%20Store,Car%20Wash,Childrens%20Apparel,Clothing%20Store,Consumer%20Electronics%20Store,Convenience%20Store,Department%20Store,Electrical,Fitness%20Center,Flea%20Market,Food%20and%20Beverage%20Shop,Footwear,Furniture%20Store,Gas%20Station,Grocery,Home%20Improvement%20Store,Market,Mens%20Apparel,Mobile%20Phone%20Shop,Motorcycle%20Shop,Office%20Supplies%20Store,Other%20Shops%20and%20Service,Pet%20Store,Pharmacy,Plumbing,Repair%20Services,Shopping%20Center,Spa,Specialty%20Store,Sporting%20Goods%20Store,Tire%20Store,Toy%20Store,Used%20Car%20Dealership,Wholesale%20Warehouse,Womens%20Apparel,Bed%20and%20Breakfast,Bridge,Bus%20Station,Cargo%20Center,Dock,Ferry,Heliport,Highway%20Exit,Hostel,Hotel,Marina,Metro%20Station,Motel,Other%20Travel,Parking,Pier,Port,Rental%20Cars,Railyard,Resort,Rest%20Area,Taxi,Tollbooth,Tourist%20Information,Train%20Station,Transportation%20Service,Truck%20Stop,Tunnel,Weigh%20Station,Canal,Channel,Cove,Dam,Delta,Estuary,Fjord,Gulf,Hot%20Spring,Irrigation,Jetty,Lagoon,Reef,Reservoir,Sea,Sound,Spring,Strait,Stream,Waterfall,Well,Wharf&location=-\(lat),\(lng)&maxLocations=25&outFields=Postal,StreetAddress,Place_addr")!
        default:
            return URL(string: "https://stg-smtshjapp.shj.ae/api")!
        }
    }
    
    var path: String {
        switch self {
        case .authenticate(let email, let password):
            return "/verifyCredential/Post?username=\(email)&password=\(password)"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .authenticate( _, _):
            return .post
        default:
            return .post
        }
     
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .authenticate(let email, let password):
            return ["email":email, "password": password]
        default:
            return [:]
        }
        
        
    }
    
    var sampleData: Data {
       return "".data(using: .utf8)!
    }
    
    var task: Task {
        if Reachability.isConnectedToNetwork() == true {
            switch self {
                
            default:
                print("Call: \(self.baseURL)\(self.path)  - Params: \(self.parameters!)")
                return .requestParameters(parameters: self.parameters!, encoding: JSONEncoding.default)
            }
            
        }
        else
        {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "No Internet Connection".localized(), message: "Make sure your device is connected to the internet.".localized(), preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "OK", style: .default) { (action) in
                //
            }
            alert.addAction(okBtn)
            UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true)
        }   
        
        return .requestPlain
        
    }
    
    var parameterEncoding: ParameterEncoding {
         return JSONEncoding.default
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var shouldAuthorize:Bool
    {
        if (self.path.contains("/api/"))
        {
            return true
        }
        
        return false
    }
    
    var authorizationType: AuthorizationType {
        
        return .basic
    }
    
    
}
