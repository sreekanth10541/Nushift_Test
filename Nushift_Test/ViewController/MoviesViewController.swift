//
//  MoviesViewController.swift
//  Nushift_Test
//
//  Created by SREEKANTH on 23/08/24.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = MoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupNavBar(self)
        self.title = "Popular Movies"
        loadPopularMoviesData()
    }
    
    private func loadPopularMoviesData() {
        viewModel.fetchPopularMoviesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.delegate = self
            self?.tableView.reloadData()
        }
    }
}

// MARK: - TableView
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        cell.selectionStyle = .none
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        
        // Navigation to details page
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
            vc.movieData = movie
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
