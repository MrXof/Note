//
//  ViewController.swift
//  Note
//
//  Created by Даниил Чугуевский on 21.03.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ObjectStoreDelegate {
  
  let cellReuseIdentifier = "cell"

  @IBOutlet weak var noteTextULabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var addNoteButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    ObjectStore.shared.delegate = self
    applyLocalization()
    acceptsCellCounter(ObjectStore.shared.objects.count)
  }
  
  //MARK: -- Actions
  
  @IBAction func addNewElement(_ sender: Any) {  // TODO: Target action pattern
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let destinationController = storyboard.instantiateViewController(withIdentifier: AddNotesViewController.controllerIdentifier) as? AddNotesViewController
    else { return }

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
      let note = ObjectStore.shared.objects[indexPath.row]
      ObjectStore.shared.edit(block: {
        note.isDone = !note.isDone
      })
      print(note)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      ObjectStore.shared.removeNote(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let destinationController = storyboard.instantiateViewController(withIdentifier: NoteInformationViewController.controllerIdentifier) as? NoteInformationViewController
    else { return }
    
    self.present(destinationController, animated: true)
    destinationController.showNote(at: indexPath.row)
  }
  
  private func applyLocalization(){
    noteTextULabel.text = NSLocalizedString("show_table_view.lable.show_note_count", comment: "")
    addNoteButton.setTitle(NSLocalizedString("show_table_view.button.add_new_reminder", comment: ""), for: .normal)
  }
  
    private func acceptsCellCounter(_ count: Int) {
    let formatString : String = NSLocalizedString("cell count", comment: "not found")
    let resultString : String = String.localizedStringWithFormat(formatString, count)
    noteTextULabel.text = resultString
  }

  //MARK: -- Methods Protocols
  
  func objectStoreDidChangeValue(_ objectStore: ObjectStore) {
    acceptsCellCounter(Int(objectStore.objects.count))
    tableView.reloadData()
    print(objectStore.objects)
  }
  
}

