//
//  DemoURL.swift
//  Cassini
//
//  Created by Chen Xiaojun on 11/7/17.
//  Copyright © 2017 Lindenbaum Pty Ltd. All rights reserved.
//

import Foundation

struct DemoURL {
    static let NASA: Dictionary<String, URL> = {
        let NASAURLStrings = [
            "Eve": "http://www.lindenbaum.net.au/others/svg/3.jpg",
            "Me": "http://www.lindenbaum.net.au/others/svg/1.jpg",
            "Us": "http://www.lindenbaum.net.au/others/svg/2.jpg"
        ]
        var urls = Dictionary<String, URL>()
        for (key, values) in NASAURLStrings {
            urls[key] = URL(string: values)
        }
        return urls
    }()
}
