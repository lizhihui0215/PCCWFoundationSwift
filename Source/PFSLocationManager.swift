//
//  BDLocationManager.swift
//  ResourceManager
//
//  Created by 李智慧 on 25/04/2017.
//  Copyright © 2017 北京海睿兴业. All rights reserved.
//
import MapKit

public typealias AMSearchCompletionHandler = ([AMapPOI]) -> Void

public typealias AMLocationCompletionHandler = (CLLocation) -> Void

open class AMLocationManager: NSObject, AMapSearchDelegate, AMapLocationManagerDelegate {
    var search: AMapSearchAPI?
    
    var locationManager = AMapLocationManager()
    
    var locationCompletionHandler: AMLocationCompletionHandler?
    
    var searchCompletionHandler: AMSearchCompletionHandler?
    
    open override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = 200
    }
    
    
    open func startUpdatingLocation(completionHandler: @escaping AMLocationCompletionHandler)  {
        self.locationCompletionHandler = completionHandler
        self.locationManager.startUpdatingLocation()
    }
    
    open func search(query: String = "", page: Int, count: Int, completionHandler: @escaping AMSearchCompletionHandler)  {
        self.searchCompletionHandler = completionHandler
        self.startUpdatingLocation {[weak self] location in
            
            let request = AMapPOIAroundSearchRequest()
            if let strongSelf = self {
                strongSelf.search = AMapSearchAPI()
                strongSelf.search?.delegate = self
                strongSelf.locationManager.stopUpdatingLocation()
                request.location = AMapGeoPoint.location(withLatitude: CGFloat(location.coordinate.latitude), longitude: CGFloat(location.coordinate.longitude))
                request.keywords = query
                request.page = page
                request.offset = count
                request.requireExtension = true
                strongSelf.search?.aMapPOIAroundSearch(request)
            }
        }
    }
    
    open func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!) {
        if let locationCompletionHandler = self.locationCompletionHandler {
            locationCompletionHandler(location)
        }
    }
    
    open func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if let searchCompletionHandler = self.searchCompletionHandler {
            searchCompletionHandler(response.pois)
        }
    }
    
    deinit {
        self.locationManager.stopUpdatingLocation()
    }

}
