//
//  TagsView.swift
//  Day60Challenge
//
//  Created by John Mueller on 11/25/19.
//  Copyright © 2019 John Mueller. All rights reserved.
//

import SwiftUI

struct TagsView: View {
    let tags: [String]
    let width: CGFloat
    private let padding: CGFloat = 10
    private let spacing: CGFloat = 10

    private func laidoutTags(in width: CGFloat) -> [[String]] {
        let spacing: CGFloat = 10

        guard tags.count > 0 else { return [] }

        var tagWidths = tags.map { tag in
            tag.sizeForTextStyle(.body).width + 2 * padding
        }

        var breakIndices: [Int] = [0]
        tagWidths.indices.dropFirst().forEach { index in
            if tagWidths[index] + tagWidths[index - 1] + spacing < width {
                tagWidths[index] += tagWidths[index - 1] + spacing
            } else {
                breakIndices.append(index)
            }
        }
        breakIndices.append(tagWidths.count)

        return zip(breakIndices.dropLast(), breakIndices.dropFirst()).map { (startIndex, endIndex) in
            Array(tags[startIndex..<endIndex])
        }
    }

    var body: some View {
        VStack(spacing: 5) {
            ForEach(self.laidoutTags(in: width), id: \.self) { row in
                HStack(spacing: self.spacing) {
                    ForEach(row, id: \.self) { tag in
                        Text(tag)
                            .padding(.horizontal, self.padding)
                            .padding(.vertical, 5)
                            .background(Capsule().fill(Color("blue")))
                    }
                }
            }
        }
    }
}

extension String {
    fileprivate func sizeForTextStyle(_ textStyle: UIFont.TextStyle) -> CGSize {
        let font = UIFont.preferredFont(forTextStyle: textStyle)
        return self.size(withAttributes: [.font: font])
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView(tags: ["some", "test", "tags"], width: 300)
    }
}
