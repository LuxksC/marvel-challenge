import UIKit

class EventsViewController: UIViewController {
    
    // MARK: - Private variables
    
    fileprivate enum ViewState {
        case loading
        case normal
        case error
    }
    
    fileprivate var state: ViewState = .normal {
        didSet {
            self.setupView()
        }
    }
    
    internal var viewModel: EventsViewModel
    
    private var loading = UIActivityIndicatorView(style: .large)
    
    // MARK: - Public Variables
    
    lazy var tableview: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.bg
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.text
        label.text = "Empty Message"
        label.textAlignment = .center
        return label
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
        configureNavigationBar()
        
        configureTableView()
        
        registerCells()
        
        configLoadingIndicator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self

        state = .loading
        showLoadingIndicator()
        
        fetchEvents()
        
    }
    
    //MARK: - Private methods
    
    private func configureNavigationBar() {
        title = viewModel.name
        
        navigationItem.largeTitleDisplayMode = .always
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
    
    private func configLoadingIndicator() {
        loading.color = .systemRed
        loading.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loading)
        
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func registerCells() {
        tableview.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
    }
    
    private func fetchEvents() {
        viewModel.fetchEvents()
    }
    
    private func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.loading.startAnimating()
            self.loading.isHidden = false
        }
    }
    
    private func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.loading.stopAnimating()
            self.loading.isHidden = true
        }
    }
    
    private func setupView() {
        
        switch state {
        case .loading:
            print("loading")
        case .normal:
            print("normal")
            DispatchQueue.main.async {
                self.tableview.reloadData()
                if self.viewModel.events.count == 0 {
                    self.emptyMessageLabel.text = "No events registred"
                    self.tableview.backgroundView = self.emptyMessageLabel
                }
            }
        case .error:
            print("error")
        }
        
        self.hideLoadingIndicator()
        
    }
}

extension EventsViewController: EventsViewModelDelegate {
    func eventsFetchWithSucess() {
        state = .normal
    }
    
    func errorToFetchEvents(_ error: String) {
        print(error)
        state = .error
    }
    
    
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell else {return UITableViewCell() }
        
        let event = viewModel.events[indexPath.row]
        
        cell.backgroundColor = UIColor.bg
        
        cell.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        
        cell.getCellData(with: event)
        
        return cell
    }
    
    
}
