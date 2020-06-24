//
//  ViewController.swift
//  aprilTestArchitecture
//
//  Created by Dimitar Grudev on 23.06.20.
//  Copyright © 2020 Dimitar Grudev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dataLabel: UILabel!
    
    var viewModel: ViewModel?
    
    // MARK: - Observable
    private var disposal = Disposal()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        requestData()
    }
    
    private func bind() {
        
        // NOTE: - Capturing self as weak reference is very important to prevent memory leaks if it's called. [weak self]
        viewModel?.observeLoading.observe { (newValue, oldValue) in
            print("LOADING: \(newValue)")
        }.add(to: &disposal)
        
        // NOTE: - Capturing self as weak reference is very important to prevent memory leaks if it's called. [weak self]
        viewModel?.dataSource.observe { [weak self] (newValue, oldValue) in
            switch newValue {
            case .success(let data):
                print("NEW DATA ARRIVED: \(data.count)")
                self?.dataLabel.text = "Data \n Returned objects: \(data.count)"
            case .failure(let error):
                print("ERROR: Handle data error \(error.message)")
            case .none:
                print("ERROR: Handle empty data error")
            }
        }.add(to: &disposal)
        
    }
    
    private func requestData() {
        let request = DataRequest(numberOfItems: 5, filter: nil)
        viewModel?.getData(request)
    }

}
