//
//  CoreDataNSAttributedStringTransformerExampleApp.swift
//  CoreDataNSAttributedStringTransformerExample
//
//  Created by yueyue max on 2023/1/12.
//

import SwiftUI

@main
struct CoreDataNSAttributedStringTransformerExampleApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        // remove this comment on step 3
         //NSAttributedStringTransformer.register()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.context)
        }
    }
}
