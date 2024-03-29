//
//  CustomTableViewCell.swift
//  Note
//
//  Created by Даниил Чугуевский on 25.03.2024.
//

import UIKit

class NoteTableViewCell: UITableViewCell{
  var buttonStatus: Bool = true
  var uiImage = "largecircle.fill.circle"
  
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var statusButton: UIButton!
  @IBOutlet weak var labelText: UILabel!
  
  @IBAction func tapButton(_ sender: Any) {
    buttonStatus = !buttonStatus
    if buttonStatus{
      statusButton.setImage(UIImage(named: "circle"), for: .normal)
    }else{
      statusButton.setImage(UIImage(systemName: uiImage)
                            , for: .normal)
    }
    
  }
  
  func displayNote(_ note: Note){
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm"
    
    if let deadLineDate = note.deadlineDate {
      let dateString = dateFormatter.string(from: deadLineDate)
      let timeString = timeFormatter.string(from: deadLineDate)
      
      let atribitedText = NSMutableAttributedString(string: "\(dateString) \(timeString)")
      atribitedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: dateString.count))
      atribitedText.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: dateString.count + 1, length: timeString.count))
      
      timeLabel.attributedText = atribitedText
    }else{
      timeLabel.text = ""
    }
    
    labelText.text = note.name
    labelText.numberOfLines = 0
    contentView.layer.cornerRadius = 10
    
  }
  
}
