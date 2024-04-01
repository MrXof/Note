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
  @IBOutlet weak var addNoteButton: UIButton!
  
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
    
    if let presentationController = destinationController.presentationController as? UISheetPresentationController {
    }
    self.present(destinationController, animated: true)
  }
  
  //MARK: -- Methods
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ObjectStore.shared.objects.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell
    
    cell.display(ObjectStore.shared.objects[indexPath.row])
    cell.didRequestChangeStatus = { _ in
      var note = ObjectStore.shared.objects[indexPath.row]
      note.isDone = !note.isDone
      ObjectStore.shared.edit(note: note)
      print(note)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      ObjectStore.shared.clearTableViewCell(index: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let destinationController = storyboard.instantiateViewController(withIdentifier: NoteInformationViewController.controllerIdentifier) as? NoteInformationViewController
    else { return }
    if let presentationController = destinationController.presentationController as? UISheetPresentationController {
    }
    self.present(destinationController, animated: true)
    destinationController.index(indexPath.row)
  }
  
  //MARK: -- Methods Protocols
  
  func objectStoreDidChangeValue(_ objectStore: ObjectStore) {
    tableView.reloadData()
  }
  
}

