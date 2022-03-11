//
//  String+trimmed.swift
//  To Do List
//
//  Created by Mac on 1/26/22.
//  Copyright © 2022 ramy. All rights reserved.
//

import Foundation

extension String {
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
