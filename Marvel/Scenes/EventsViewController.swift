import UIKit

class EventsViewController: UIViewController {
    
    // MARK: - Private variables
    
    private var viewModel: EventsViewModel
    
    // MARK: - Public Variables
    
    lazy var tableview: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    //MARK: - Initializers
    
    public init(viewModel: EventsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        configureNavigationBar()
        
        configureTableView()
        
        registerCells()
        
        print(viewModel.events)
        
    }
    
    //MARK: - Private methods
    
    private func configureNavigationBar() {
        title = "Hero Name"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func registerCells() {
        tableview.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell else {return UITableViewCell() }
        
        let event = viewModel.events[indexPath.row]
        
        cell.getCellData(with: event, rowNumber: indexPath.row + 1)
        
        return cell
    }
    
    
}
