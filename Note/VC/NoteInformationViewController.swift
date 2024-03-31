//
//  NoteInformation.swift
//  Note
//
//  Created by Даниил Чугуевский on 27.03.2024.
//

import UIKit

class NoteInformationViewController: UIViewController{
  
  @IBOutlet weak var centerLabelTextOutput: UILabel!
  @IBOutlet weak var timeInformation: UILabel!
  @IBOutlet weak var timeView: UIView!
  @IBOutlet weak var doneButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var optionalViewTime: UIView!
  @IBOutlet weak var dataPicker: UIDatePicker!
  @IBOutlet weak var showEditMode: UIButton!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var switchDataAndTime: UISwitch!
  
  static let controllerIdentifier = "NoteInformationViewController"
  var defaultValueIsDone: Bool = false
  var isDone = Date()
  var bufferString = String()
  var indexRow = 0
  var isDateEnabled: Bool = false
  var date = ObjectStore.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    doneButton.isHidden = true
    cancelButton.isHidden = true
    optionalViewTime.isHidden = true
    textView.isHidden = true
    dataPicker.overrideUserInterfaceStyle = .dark
  }
  
  func index(_ index: Int){
    var note = ObjectStore.shared.objects
    centerLabelTextOutput.text = note[index].name
    indexRow = index
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    
    if let deadlineDate = note[index].deadlineDate {
      let timeString = dateFormatter.string(from: deadlineDate)
      timeInformation.text = timeString
      self.dataPicker.date = deadlineDate
    } else {
      timeInformation.text = ""
      timeView.backgroundColor = .clear
    }
    let checkValue = note[index].deadlineDate
    if checkValue != nil{
      self.switchDataAndTime.isOn = true
    }else{
      self.switchDataAndTime.isOn = false
    }
  }
  
  
  //MARK: -- Methods
  
  @IBAction func showEditMode(_ sender: Any) {
    // animation
    doneButton.alpha = 0.0
    cancelButton.alpha = 0.0
    optionalViewTime.alpha = 0.0
    showEditMode.alpha = 1.0
    dataPicker.alpha = 0.0
    self.textView.isHidden = false
    self.doneButton.isHidden = false
    self.cancelButton.isHidden = false
    self.optionalViewTime.isHidden = false
    self.showEditMode.isHidden = true
    
    if switchDataAndTime.isOn{
      self.dataPicker.isHidden = false
      self.dataPicker.alpha = 1.0
    }else{
      self.dataPicker.isHidden = true
    }
    
    UIView.animate(withDuration: 0.3) {
      self.doneButton.alpha = 1.0
      self.cancelButton.alpha = 1.0
      self.optionalViewTime.alpha = 1.0
      self.showEditMode.alpha = 0.0
    }
    // setting
    
    self.bufferString = self.centerLabelTextOutput.text!  //TODO: тут завжди будуть дані
    self.textView.text = bufferString
    self.centerLabelTextOutput.text = nil
  }
  
  @IBAction func cancelSettings(_ sender: Any) {
    self.doneButton.isHidden = true
    self.cancelButton.isHidden = true
    self.optionalViewTime.isHidden = true
    self.showEditMode.alpha = 1.0
    self.showEditMode.isHidden = false
    
    self.textView.text = nil
    self.centerLabelTextOutput.text = bufferString
  }
  
  @IBAction func doneSettings(_ senders: Any) {
    let count: Int = ObjectStore.shared.objects.count
    print(count)
    if textView.text != "Нотатки" && (textView.text != nil) != textView.text.isEmpty{
      if switchDataAndTime.isOn{
        date.edit( note: Note(id: count, name: textView.text, isDone: defaultValueIsDone, deadlineDate: isDone))
        dismiss(animated: true)
      }else{
        date.edit( note: Note(id: count, name: textView.text, isDone: defaultValueIsDone, deadlineDate: nil))

        dismiss(animated: true)
      }
    }
  }
  
  @IBAction func dateHasChange(_ sender: Any) {
    isDateEnabled = !isDateEnabled
    if isDateEnabled{
      isDone = self.dataPicker.date
    }else{}
  }
  
  @IBAction func showDataPicker(_ sender: Any) {
    if switchDataAndTime.isOn {
      self.dataPicker.isHidden = false
      dataPicker.alpha = 1.0
    }else{
      self.dataPicker.isHidden = true
    }
  }
  
}
