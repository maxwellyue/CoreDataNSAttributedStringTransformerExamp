//
//  Note.swift
//  CoreDataNSAttributedStringTransformerExample
//
//  Created by yueyue max on 2023/1/12.
//

import CoreData
import UIKit

@objc(Note)
public class Note: NSManagedObject {
    @NSManaged public var id: String?
    @NSManaged public var attributedContent: NSAttributedString?
    @NSManaged public var createTime: Date?
}

extension Note {
    static func addNote() {
        let context = PersistenceController.shared.context
        let note = Note(context: context)
        note.id = UUID().uuidString

        let now = Date.now

        // Append some random characters
        let content = NSMutableAttributedString(string: String.random(length: 120))
        content.append(NSAttributedString(string: "\n"))
        // Append random image
        let imageAttachment = NSTextAttachment()
        let imageName = String(format: "%02d", Int(now.timeIntervalSince1970) % 50) + ".circle.fill"
        imageAttachment.image = UIImage(systemName: imageName)!
        let imageAttributedString = NSAttributedString(attachment: imageAttachment)
        content.append(imageAttributedString)
        note.attributedContent = content

        note.createTime = now
        try? context.save()
    }
}

extension String {
    static func random(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0 ..< length).map { _ in letters.randomElement() ?? "_" })
    }
}
