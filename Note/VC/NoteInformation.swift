//
//  NoteInformation.swift
//  Note
//
//  Created by Даниил Чугуевский on 27.03.2024.
//

import Foundation
import UIKit

class NoteInformation: UIViewController{

  @IBOutlet weak var labelInformation: UILabel!
  @IBOutlet weak var timeInformation: UILabel!
  @IBOutlet weak var timeView: UIView!
  @IBOutlet weak var settingsButtonDone: UIButton!
  @IBOutlet weak var settingsButtonCancel: UIButton!
  @IBOutlet weak var optionalViewTime: UIView!
  @IBOutlet weak var dataPicker: UIDatePicker!
  @IBOutlet weak var buttonSetting: UIButton!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var statusData: UISwitch!
  
  static let controllerIdentifier = "NoteInformation"
  var defaultValue: Bool = false
  var dataValue = Date()
  var buffer = String()
  var indexRow = Int()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    settingsButtonDone.isHidden = true
    settingsButtonCancel.isHidden = true
    optionalViewTime.isHidden = true
    textView.isHidden = true
    dataPicker.overrideUserInterfaceStyle = .dark
  }
  
  func sender(_ sender: Int){
    labelInformation.text = ObjectStore.shared.objects[sender].name
    indexRow = sender
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    
    if let deadlineDate = ObjectStore.shared.objects[sender].deadlineDate {
      let timeString = dateFormatter.string(from: deadlineDate)
      timeInformation.text = timeString
    } else {
      timeInformation.text = ""
      timeView.backgroundColor = .clear
    }
    
  }
  
  //MARK: -- Methods
  
  @IBAction func ShowSettings(_ sender: Any) {
    // animation
    settingsButtonDone.alpha = 0.0
    settingsButtonCancel.alpha = 0.0
    optionalViewTime.alpha = 0.0
    buttonSetting.alpha = 1.0
    self.textView.isHidden = false
    self.settingsButtonDone.isHidden = false
    self.settingsButtonCancel.isHidden = false
    self.optionalViewTime.isHidden = false
    self.buttonSetting.isHidden = true
    
    UIView.animate(withDuration: 0.3) {
      self.settingsButtonDone.alpha = 1.0
      self.settingsButtonCancel.alpha = 1.0
      self.optionalViewTime.alpha = 1.0
      self.buttonSetting.alpha = 0.0
    }
    // setting
    
    self.buffer = self.labelInformation.text!  //TODO: тут завжди будуть дані
    self.textView.text = buffer
    self.labelInformation.text = nil
  }
  
  @IBAction func cancelSettings(_ sender: Any) {
    self.settingsButtonDone.isHidden = true
    self.settingsButtonCancel.isHidden = true
    self.optionalViewTime.isHidden = true
    self.buttonSetting.alpha = 1.0
    self.buttonSetting.isHidden = false
    
    self.textView.text = nil
    self.labelInformation.text = buffer
  }
  
  @IBAction func doneSettings(_ senders: Any) {
    let count: Int = ObjectStore.shared.objects.count
    if textView.text != "Нотатки" && (textView.text != nil) != textView.text.isEmpty{
      if statusData.isOn{
        ObjectStore.shared.edit(index: indexRow, note: Note(id: count, name: textView.text, isDone: defaultValue, deadlineDate: dataValue))
        dismiss(animated: true)
      }else{
        ObjectStore.shared.edit(index: indexRow, note: Note(id: count, name: textView.text, isDone: defaultValue, deadlineDate: nil))

        dismiss(animated: true)
      }
    }
  }
}
