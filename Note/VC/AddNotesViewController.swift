//
//  ModalViewController.swift
//  Note
//
//  Created by Даниил Чугуевский on 22.03.2024.
//

import Foundation
import UIKit

class AddNotesViewController: UIViewController, UITextViewDelegate {
  
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var doneButton: UIButton!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var switchDate: UISwitch!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var detailsLabel: UILabel!
  
  private var dateValue = Date()
  
  static let controllerIdentifier = "ModalViewController"
  override func viewDidLoad() {
    super.viewDidLoad()
    
    editButton()
    setupTextView()
    datePicker.overrideUserInterfaceStyle = .dark
    applyLocalization()
  }
  
  //MARK: -- Methods
  
  func editButton() {
    let boldFont = UIFont.boldSystemFont(ofSize: 17)
    doneButton.titleLabel?.font = boldFont
  }
  
  func setupTextView() {
    textView.delegate = self
    textView.text = NSLocalizedString("add_note.note.placeholder", comment: "")
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
      textView.text = NSLocalizedString("add_note.note.placeholder", comment: "")
      textView.textColor = UIColor.lightGray
    }
  }
  
  private func applyLocalization(){
    cancelButton.setTitle(NSLocalizedString("add_note.cancel_button.title", comment: ""), for: .normal)
    doneButton.setTitle(NSLocalizedString("add_note.done_button.title", comment: ""), for: .normal)
    detailsLabel.text = NSLocalizedString("add_note.label.text", comment: "")
  }
  
  @IBAction func completionButton(_ sender: Any) {
    guard textView.text != NSLocalizedString("add_note.note.placeholder", comment: "") && !textView.text.isEmpty else { return }
    
    let newDate = switchDate.isOn ? dateValue : nil
    ObjectStore.shared.add(note: Note(name: textView.text, isDone: false, deadlineDate: newDate))
    dismiss(animated: true)
  }
  
  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true)
  }
  
  @IBAction func dataChoice(_ sender: Any) {
    
    if switchDate.isOn {
      self.datePicker.alpha = 1.0
      self.datePicker.isHidden = false

    } else {
      self.datePicker.alpha = 0.0
      self.datePicker.isEnabled = true
    }
  }
  
  @IBAction func applyDateAndTime(_ sender: Any) {
    dateValue = self.datePicker.date
  }
  
}
