//
//  DateExtension.swift
//  MC7-Camp
//
//  Created by Paula Leite on 10/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

extension Date {
    var second: Int {
        return Calendar.current.component(.second, from: self)
    }
}
