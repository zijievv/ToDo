//
//  Date+Extension.swift
//  ToDo
//
//  Created by zijie vv on 04/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import Foundation
import SwiftUI

extension Date {
    func dateFormatterString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: self)
    }
}
