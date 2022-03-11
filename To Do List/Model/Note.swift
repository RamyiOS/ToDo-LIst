//
//  Note.swift
//  To Do List
//
//  Created by Mac on 1/20/22.
//  Copyright © 2022 ramy. All rights reserved.
//

import Foundation

struct Note: Codable {
    var date: String
    var note: String
    var id: String?
}
