//
//  NSAttributedStringTransformer.swift
//  CoreDataNSAttributedStringTransformerExample
//
//  Created by yueyue max on 2023/1/12.
//

import CoreData
import UIKit

@objc(NSAttributedStringTransformer)
class NSAttributedStringTransformer: NSSecureUnarchiveFromDataTransformer {
    static let name = NSValueTransformerName(rawValue: String(describing: NSAttributedStringTransformer.self))

    override class var allowedTopLevelClasses: [AnyClass] {
        return super.allowedTopLevelClasses + [NSAttributedString.self]
    }

    public static func register() {
        let transformer = NSAttributedStringTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }

    override class func allowsReverseTransformation() -> Bool {
        return true
    }

    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let date = value as? NSAttributedString else { return nil }
        return date.toNSData()
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? NSData else { return nil }
        return data.toAttributedString()
    }
}

extension NSData {
    func toAttributedString() -> NSAttributedString? {
        let data = Data(referencing: self)
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.rtfd,
            .characterEncoding: String.Encoding.utf8
        ]

        return try? NSAttributedString(data: data,
                                       options: options,
                                       documentAttributes: nil)
    }
}

extension NSAttributedString {
    func toNSData() -> NSData? {
        let options: [NSAttributedString.DocumentAttributeKey: Any] = [
            .documentType: NSAttributedString.DocumentType.rtfd,
            .characterEncoding: String.Encoding.utf8
        ]

        let range = NSRange(location: 0, length: length)
        guard let data = try? data(from: range, documentAttributes: options) else {
            return nil
        }

        return NSData(data: data)
    }
}
