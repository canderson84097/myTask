//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Chris Anderson on 11/13/19.
//  Copyright © 2019 Renaissance Apps. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    // MARK: - Properties
    
    var task: Task? {
        didSet {
            loadViewIfNeeded()
            guard let task = task else { return }
            updateViews(task: task)
        }
    }
    var dueDateValue: Date?
    
    // MARK: - Outlets
    
    @IBOutlet weak var detailNameTextField: UITextField!
    @IBOutlet weak var detailDueDateTextField: UITextField!
    @IBOutlet weak var detailNotesTextView: UITextView!
    @IBOutlet var detailDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews(task: task)
        detailDueDateTextField.inputView = detailDatePicker
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandled))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func tapHandled() {
        detailDueDateTextField.resignFirstResponder()
    }
    
    @IBAction func detailCancelButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateValue = sender.date
        detailDueDateTextField.text = dueDateValue?.stringValue()
    }
    
    @IBAction func detailSaveButton(_ sender: UIBarButtonItem) {
        guard let name = detailNameTextField.text else { return }
        let notes = detailNotesTextView.text
        
        if let task = task {
            TaskController.sharedInstance.update(task: task, name: name, notes: notes, due: dueDateValue)
        } else {
            TaskController.sharedInstance.add(name: name, notes: notes, due: dueDateValue)
        }
        let _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func userTappedView(_ sender: Any?) {
        
    }
    
    private func updateTask() {
    
    }
    
    func updateViews(task: Task?) {
        
        detailNameTextField.text = task?.name
        detailNotesTextView.text = task?.notes
        if let date = task?.due {
            detailDueDateTextField.text = date.stringValue()
        } else {
            detailDueDateTextField.text = Date().stringValue()
        }
        
    }
} // END OF CLASS!
