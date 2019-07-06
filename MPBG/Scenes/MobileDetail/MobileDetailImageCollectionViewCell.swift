//
//  MobileDetailImageCollectionViewCell.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 5/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

import UIKit
import Kingfisher
class MobileDetailImageCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  
  var imageURLString: String? {
    didSet {
      guard  let imageURLString = self.imageURLString  else {
        return
      }
      setImageUrl(urlString: imageURLString)
    }
  }
  
  private func setImageUrl(urlString: String)
  {
    let url = URL(string: urlString)
    imageView.kf.setImage(with: url, placeholder: UIImage(named: "image-placeholder"))
  }
}
