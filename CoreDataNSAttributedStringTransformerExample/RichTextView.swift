//
//  RichTextView.swift
//  CoreDataNSAttributedStringTransformerExample
//
//  Created by yueyue max on 2023/1/12.
//

import SwiftUI
import UIKit

struct AttributedText: View {
    @State var height: CGFloat = 16

    let attributedString: NSAttributedString

    init(_ attributedString: NSAttributedString) {
        self.attributedString = attributedString
    }

    var body: some View {
        AttributedTextRepresentable(attributedString: attributedString, calculatedHeight: self.$height)
            .frame(minHeight: height, maxHeight: height)
    }

    static func uiTextView(for attributedString: NSAttributedString? = nil) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.attributedText = attributedString
        return textView
    }

    struct AttributedTextRepresentable: UIViewRepresentable {
        let attributedString: NSAttributedString
        @Binding var calculatedHeight: CGFloat

        func makeUIView(context: Context) -> UITextView {
            return AttributedText.uiTextView()
        }

        func updateUIView(_ uiView: UITextView, context: Context) {
            uiView.attributedText = attributedString

            AttributedTextRepresentable.recalculateHeight(view: uiView, result: $calculatedHeight)
        }

        fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
            let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            if result.wrappedValue != newSize.height {
                DispatchQueue.main.async {
                    result.wrappedValue = newSize.height // !! must be called asynchronously
                }
            }
        }
    }
}
