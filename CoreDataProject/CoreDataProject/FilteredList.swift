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

    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}
