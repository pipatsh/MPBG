//
//  MobileListTableViewCell.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 2/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

import UIKit
import Kingfisher

class MobileListTableViewCell: UITableViewCell
{
  @IBOutlet weak var thumbImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var favouriteButton: UIButton!
  
  private var favouriteDidChange: ((Bool) -> Void)?
  
  func display(_ displayedMobile: MobileList.DisplayedMobile, displayMethod: DisplayMethod)
  {
    let url = URL(string: displayedMobile.thumbImageURL)
    thumbImageView.kf.setImage(with: url)
    nameLabel.text = displayedMobile.name
    descriptionLabel.text = displayedMobile.description
    priceLabel.text = "Price: \(displayedMobile.price)"
    ratingLabel.text = "Rating: \(displayedMobile.rating)"
    favouriteButton.isHidden = (displayMethod.type == .favourite)
    favouriteButton.isSelected = displayedMobile.isFavourite
  }
  
  func favouriteDidChange(handler: ((Bool) -> Void)?)
  {
    favouriteDidChange = handler
  }
  
  @IBAction func favouriteButtonClicked(_ sender: Any)
  {
    favouriteButton.isSelected = !favouriteButton.isSelected
    favouriteDidChange?(favouriteButton.isSelected)
  }
}
