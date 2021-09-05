//
//  ViewController.swift
//  Marvel
//
//  Created by Julie Connors on 9/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: ViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
        tableView.dataSource = self
        tableView.register(CharacterCell.nib(), forCellReuseIdentifier: CharacterCell.identifier)
    }
    
    func setUpViewModel() {
        viewModel =  ViewModel()
        
        let completion = { [weak self] in
            guard let wself = self else { return }
            
            wself.loadCharacters()
        }
        
        viewModel.bind(completion: completion)
    }
    
    func loadCharacters() {
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.characterViewModel?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let character = self.viewModel.characterViewModel?.results[indexPath.row] else { fatalError() }
        
        guard let charCell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier) as? CharacterCell else { fatalError() }
        
        charCell.characterName.text = character.name
        
        let imageStr = viewModel.formatImageStr(character: character)
        
        viewModel.fetchImages(imageStr: imageStr) { image in
                charCell.characterImageView.image = image
            }
        
        return charCell
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let characters = viewModel.characterViewModel?.results else { fatalError() }
            let character = characters[indexPath.row]
            
            let imageStr = viewModel.formatImageStr(character: character)
            
            viewModel.fetchImages(imageStr: imageStr, completion: { _ in })
        }
    }
}
