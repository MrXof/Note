//
//  ViewController.swift
//  Note
//
//  Created by Даниил Чугуевский on 21.03.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ObjectStoreDelegate {
  
  let cellReuseIdentifier = "cell"

  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var plusButton: UIButton!
  
  var isFormattingEnabled = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    ObjectStore.shared.delegate = self
  }
  
  //MARK: -- Actions
  
  @IBAction func addNewElement(_ sender: Any) {  // TODO: Target action pattern
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let destinationController = storyboard.instantiateViewController(withIdentifier: ModalViewController.controllerIdentifier) as? ModalViewController
    else { return }
    if let presentationController = destinationController.presentationController as? UISheetPresentationController{
      presentationController.detents = [.large()]
    }
    self.present(destinationController, animated: true)
  }
  
  //MARK: -- Methods
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ObjectStore.shared.objects.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm"

    if let deadLineDate = ObjectStore.shared.objects[indexPath.row].deadlineDate {
      let dateString = dateFormatter.string(from: deadLineDate)
      let timeString = timeFormatter.string(from: deadLineDate)
      
      let atribitedText = NSMutableAttributedString(string: "\(dateString) \(timeString)")
      atribitedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: dateString.count))
      atribitedText.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: dateString.count + 1, length: timeString.count))
      
      cell.lableTime.attributedText = atribitedText
    }else{
      cell.lableTime.text = ""
    }
    
    cell.lableText.text = ObjectStore.shared.objects[indexPath.row].name
    cell.lableText.numberOfLines = 0
    cell.contentView.layer.cornerRadius = 10
  
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      ObjectStore.shared.clearTableViewCell(index: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }else if editingStyle == .insert{}
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let destinationController = storyboard.instantiateViewController(withIdentifier: NoteInformation.controllerIdentifier) as? NoteInformation
    else { return }
    if let presentationController = destinationController.presentationController as? UISheetPresentationController{
      presentationController.detents = [.large()]
    }
    self.present(destinationController, animated: true)
    destinationController.sender(indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
  }
  
  //MARK: -- Methods Protocols
  
  func objectStoreDidChangeValue(_ objectStore: ObjectStore) {
    tableView.reloadData()
  }
  
}

