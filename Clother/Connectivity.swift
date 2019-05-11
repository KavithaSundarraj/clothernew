//
//  Connectivity.swift
//  Clother
//
//  Created by DSV on 2019-05-11.
//  Copyright © 2019 DSV. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
