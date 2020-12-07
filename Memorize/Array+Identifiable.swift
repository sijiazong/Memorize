//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Sijia Zong on 12/6/20.
//  Copyright © 2020 Sijia Zong. All rights reserved.
//

import Foundation

// create index function to identified arrays
extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for idx in 0..<self.count {
            if self[idx].id == matching.id {
                return idx
            }
        }
        return nil
    }
}
