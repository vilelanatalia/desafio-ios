import UIKit

class BankStatementViewController: UIViewController {
    private let viewModel: BankStatementViewModel
    private lazy var constants = BankStatementsConstants()

    init(viewModel: BankStatementViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""

        navigationBarAppearance()
        setupTableView()
        configBindings()
        Task {
            do {
                try await viewModel.getList()
            }
        }
    }

    private func configBindings() {
        viewModel.onBankStatementFetched = { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func navigationBarAppearance() {
        navigationItem.title = constants.navigationTitle
    }

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.white
        tableView.register(BankStatementTableViewCell.self, forCellReuseIdentifier: "BankStatementCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionFooterHeight = 0
        tableView.contentInset = .zero

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension BankStatementViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int {
        let date = viewModel.transactionsDatesSorted[numberOfRowsInSection]

        return viewModel.transactionsByDate[date]?.count ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BankStatementCell", for: indexPath) as? BankStatementTableViewCell
        else {
            return .init()
        }

        cell.backgroundColor = Colors.white
        let date = viewModel.transactionsDatesSorted[indexPath.section]
        let transactions = viewModel.transactionsByDate[date]
        let statement = transactions?[indexPath.row]
        let status = viewModel.getTransactionLabel(label: statement?.items.first?.label)
        let formattedAmount = formatAmount(value: statement?.items.first?.amount)
        let formattedDate = formatDate(from: statement?.items.first?.dateEvent, formatType: .timeOnly)
        // Aqui você configura os valores da célula

        if let status {
            cell.transactionIconImageView.image = UIImage(named: status.symbol)
        } else {
            cell.transactionIconImageView.image = UIImage(named: "arrow-up")
        }
        cell.amountLabel.text = "R$ \(formattedAmount)"
        cell.descriptionLabel.text = statement?.items.first?.label
        cell.nameLabel.text = statement?.items.first?.name

        cell.dateEventLabel.text = formattedDate

        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // Altura automática baseada no conteúdo
    }

    func numberOfSections(in _: UITableView) -> Int {
        return viewModel.transactionsByDate.count
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = Colors.grayscale4

        let label = UILabel()
        let sortedDates = viewModel.transactionsByDate.keys.sorted(by: { $0 > $1 })

        let formattedDate = formatDate(from: sortedDates[section], formatType: .fullDate)
        label.text = formattedDate
        label.textColor = Colors.grayscale2
        label.font = Fonts.xxsRegular.font

        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
        ])

        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedTransaction = viewModel.bankStatement.results[indexPath.row]
        let detailViewController = TransferDetailsViewController(
            viewModel: .init(
                transferDetailsUseCase: TransferDetailsUseCase(),
                userID: selectedTransaction.items.first?.id ?? ""
            )
        )
        detailViewController.transaction = selectedTransaction
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
