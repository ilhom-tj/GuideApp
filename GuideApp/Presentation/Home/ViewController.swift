//
//  ViewController.swift
//  GuideApp
//
//  Created by Ilhom Rahimov on 09/03/23.
//

import UIKit
import RxSwift
import SDWebImage

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
   
    
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel(useCase: FetchUpcomingUseCaseImpl())
    
    
    private lazy var guideTable : UITableView  = {
        let table = UITableView(frame: .zero,style: .plain)
        return table
    }()
    
    
    private func fatalError(){
        print("Error")
    }
    
    private var guides = [GuideData]() {
        didSet{
            
            // Cause of network presponse have no pagging feature i had do something like this to be simmilar for pagging
            if guides.count > 0 {
                displayedData.append( contentsOf:  Array(guides[0..<3]))
                guideTable.reloadData()
            }
            
        }
    }
    private var displayedData = [GuideData](){
        didSet{
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        title = "Guides"
        navigationController?.navigationBar.prefersLargeTitles = true
        guideTable.estimatedRowHeight = 80
        guideTable.rowHeight = UITableView.automaticDimension
        guideTable.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(guideTable)
        
        
        NSLayoutConstraint.activate([
            guideTable.topAnchor.constraint(equalTo: self.view.topAnchor),
            guideTable.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            guideTable.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            guideTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        guideTable.delegate = self
        guideTable.dataSource = self
        
        guideTable.register(GuideCell.unib, forCellReuseIdentifier: GuideCell.id)
        
        setBindings()
        
    }
    private var lastLoadedIndex = 2
    private var isLoading = true
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        //Some kind of pagging logic due to the Network response
        
        let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            if offsetY > contentHeight - scrollView.frame.size.height {
                // Load the next 3 items of data
                if isLoading {
                    return
                }
                let newDataCount = displayedData.count + 3
                if newDataCount < guides.count {
                            // Load the next 3 items of data
                            let nextData = Array(guides[lastLoadedIndex+1..<lastLoadedIndex+4])
                            lastLoadedIndex += 3
                            
                            // Add the new data to the current data
                            displayedData += nextData
                            
                            // Update the TableView
                            guideTable.reloadData()
                        }else {
                            // Make a network request to get more data
                            isLoading = true
                            
                            //Some kind of response
                            
                        }
                
                
            }
    }
    
    private func setBindings(){
        
        //Fetching data from local storage
        viewModel.localItems
            .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { [weak self] items in
                        print(items)
                        self?.guides.append(contentsOf: items)
                    })
                    .disposed(by: disposeBag)

        
        //Fetching loading state
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { [weak self] isLoading in
                        self?.isLoading = isLoading
                        self?.viewModel.fetchItems()
                    })
                    .disposed(by: disposeBag)

        //Fetching some error state
        viewModel.error
            .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { error in
                        print(error.localizedDescription)
                    })
                    .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GuideCell.id, for: indexPath) as! GuideCell
        let guide = guides[indexPath.row]
        cell.setGuide(guide: guide)
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let guide = displayedData[indexPath.row]
        let guideScreen = GuideScreen(urlToLoad: guide.uri)
        self.navigationController?.present(guideScreen, animated: true)
    }

}

