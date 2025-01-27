//
//  LoationManager.swift
//  HotpepperAPI
//
//  Created by x22021xx on 2025/01/24.
//

import Foundation
import CoreLocation //位置情報

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    //位置情報の取得
    let manager = CLLocationManager()
    //位置情報の保持
    @Published var location = CLLocation()
    
    //位置情報の更新
    override init() {
        super.init()
        
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.distanceFilter = 2
        self.manager.startUpdatingLocation()
    }
    
    //位置情報の使用リクエスト
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
    
    //位置情報の設定
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last!
    }
}
