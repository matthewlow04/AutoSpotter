//
//  DateFormatter.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-11-09.
//

import Foundation

func formattedDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    return dateFormatter.string(from: date)
}
