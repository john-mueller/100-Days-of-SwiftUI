//
//  FilteredLIst.swift
//  CoreDataProject
//
//  Created by John Mueller on 11/20/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var results: FetchedResults<T> { fetchRequest.wrappedValue }

    let content: (T) -> Content

    var body: some View {
        List(results, id: \.self) { result in
            self.content(result)
        }
    }

    init(filterKey: String,
         filterType: FilterType,
         filterValue: String,
         sortDescriptors: [NSSortDescriptor] = [],
         @ViewBuilder content: @escaping (T) -> Content) {

        fetchRequest = FetchRequest<T>(entity: T.entity(),
                                       sortDescriptors: sortDescriptors,
                                       predicate: NSPredicate(format: "%K \(filterType.rawValue) %@", filterKey, filterValue))
        self.content = content
    }

    enum FilterType: String {
        case beginsWith = "BEGINSWITH"
        case beginsWithCaseInsensitive = "BEGINSWITH[c]"
        case contains = "CONTAINS"
        case containsCaseInsensitive = "CONTAINS[c]"
        case endsWith = "ENDSWITH"
        case endsWithCaseInsensitive = "ENDSWITH[c]"
    }
}
