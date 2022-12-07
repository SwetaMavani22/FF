//
//  PDFGlobal.swift
//  StarCall
//
//  Created by Techno Exponent on 27/04/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import Foundation
import UIKit
import PDFKit


func humanReadableByteCount(bytes: Int) -> String {
    if (bytes < 1000) { return "\(bytes) B" }
    let exp = Int(log2(Double(bytes)) / log2(1000.0))
    let unit = ["KB", "MB", "GB", "TB", "PB", "EB"][exp - 1]
    let number = Double(bytes) / pow(1000, Double(exp))
    return String(format: "%.1f %@", number, unit)
}


func pdfThumbnail(url: URL, width: CGFloat = 240) -> UIImage? {
  guard let data = try? Data(contentsOf: url),
  let page = PDFDocument(data: data)?.page(at: 0) else {
    return nil
  }

  let pageSize = page.bounds(for: .mediaBox)
  let pdfScale = width / pageSize.width

  // Apply if you're displaying the thumbnail on screen
  let scale = UIScreen.main.scale * pdfScale
  let screenSize = CGSize(width: pageSize.width * scale,
                          height: pageSize.height * scale)

  return page.thumbnail(of: screenSize, for: .mediaBox)
}
