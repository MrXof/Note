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
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    
    let deadLineDate = ObjectStore.shared.objects[indexPath.row].deadlineDate
    let dateString = dateFormatter.string(from: deadLineDate)
    
    cell.labelText.text = ObjectStore.shared.objects[indexPath.row].name
    cell.labelTime.text = dateString
    cell.labelTime.textColor = .red
    cell.contentView.backgroundColor = .lightGray
    cell.contentView.layer.cornerRadius = 10
    
    return cell
  }
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ObjectStore.shared.clearTableViewCell(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }else if editingStyle == .insert{}
      
    }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 77
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

  }
  
  func objectStoreDidChangeValue(_ objectStore: ObjectStore) {
    tableView.reloadData()
  }
  
}

