//
//  ModalViewController.swift
//  Note
//
//  Created by Даниил Чугуевский on 22.03.2024.
//

import Foundation
import UIKit

class ModalViewController: UIViewController, UITextViewDelegate{
  
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var completionOfAddition: UIButton!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var statusData: UISwitch!
  
  var defaultValue: Bool = false
  var switchValue: Bool = false
  var dataValue = Date()
  
  static let controllerIdentifier = "ModalViewController"
  override func viewDidLoad() {
    super.viewDidLoad()
    
    editButton()
    customTextView()
    datePicker.overrideUserInterfaceStyle = .dark
  }
  
  //MARK: -- Methods
  
  func editButton(){
    let boldFont = UIFont.boldSystemFont(ofSize: 17)
    completionOfAddition.titleLabel?.font = boldFont
  }
  
  func customTextView(){
    textView.delegate = self
    textView.text = "Нотатки"
    textView.textColor = UIColor.lightGray
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.lightGray{
      textView.text = nil
      textView.textColor = UIColor.white
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "Нотатки"
      textView.textColor = UIColor.lightGray
    }
  }
  
  @IBAction func completionButton(_ sender: Any) {
    let count: Int = ObjectStore.shared.objects.count
    if textView.text != "Нотатки" && (textView.text != nil) != textView.text.isEmpty{
      if statusData.isOn{
        ObjectStore.shared.add(note: Note(id: count, name: textView.text, isDone: defaultValue, deadlineDate: dataValue))
      }else{
        ObjectStore.shared.add(note: Note(id: count, name: textView.text, isDone: defaultValue, deadlineDate: nil))
      }
      dismiss(animated: true)
    }
  }
  
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true)
  }
  
  @IBAction func dataChoice(_ sender: Any) {
    switchValue = !switchValue
    if switchValue{
      print("true")
      dataValue = self.datePicker.date
      print(dataValue)
    }else{
      print("false")
    }
    
  }
  
}
