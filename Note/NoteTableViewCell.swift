//
//  CustomTableViewCell.swift
//  Note
//
//  Created by Даниил Чугуевский on 25.03.2024.
//

import Foundation
import UIKit

class NoteTableViewCell: UITableViewCell{
  
  var largecircleStatusL: Bool = false
  
  @IBOutlet weak var selector: UIView!
  @IBOutlet weak var labelTime: UILabel!
  @IBOutlet weak var StatusButton: UIButton!
  @IBOutlet weak var labelText: UILabel!
  
  @IBAction func tabButton(_ sender: Any) {
    largecircleStatusL = !largecircleStatusL
    if largecircleStatusL{
      StatusButton.setImage(UIImage(named: "circle"), for: .normal)
    }else{
      StatusButton.setImage(UIImage(systemName: "largecircle.fill.circle")
                            , for: .normal)
    }
  }
  
}
