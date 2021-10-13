//
//  File.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 12.10.2021.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var name: String?
    @objc dynamic var about: String?
}
