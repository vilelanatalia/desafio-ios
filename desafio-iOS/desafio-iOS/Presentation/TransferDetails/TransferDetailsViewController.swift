import UIKit

class TransferDetailsViewController: UIViewController {
    private let transferDetailsView = TransferDetailsView()
    private let viewModel: TransferDetailsViewModel
    private var constants = TransferDetailsViewConstants()

    var transaction: ResultItem?

    init(viewModel: TransferDetailsViewModel, transaction: ResultItem? = nil) {
        self.viewModel = viewModel
        self.transaction = transaction
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view = transferDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearance()
        transferDetailsView.setup()
        getTransferDetails()
    }

    private func getTransferDetails() {
        viewModel.onTransferDetailsFetched = { [weak self] details in
            self?.updateUI(with: details)
        }
        Task {
            do {
                try await viewModel.getTransferDetails()
            }
        }
    }

    private func updateUI(with _: TransferDetailsResponseModel) {
        // MARK: titleStackView

        if let title = transferDetailsView.titleStackView.arrangedSubviews[1] as? UILabel {
            title.text = String(viewModel.transferDetails.label)
        }

        // MARK: valueStackView

        if let value = transferDetailsView.valueStackView.arrangedSubviews[1] as? UILabel {
            value.text = "R$ \(String(formatAmount(value: viewModel.transferDetails.amount)))"
        }

        // MARK: dateStackView

        if let date = transferDetailsView.dateStackView.arrangedSubviews[1] as? UILabel {
            let formattedDate = formatDate(from: viewModel.transferDetails.dateEvent, formatType: .prefixDate)
            date.text = formattedDate
        }

        // MARK: senderStackView

        if let senderNameAccount = transferDetailsView.senderStackView.arrangedSubviews[1] as? UILabel {
            senderNameAccount.text = String(viewModel.transferDetails.sender.name)
        }
        if let senderRegister = transferDetailsView.senderAccountInformationStackView.arrangedSubviews[0] as? UILabel {
            let documentType = viewModel.getDocumentType(document: viewModel.transferDetails.sender.documentType)
            let documentFormatted = documentFormatter(viewModel.transferDetails.sender.documentNumber, type: documentType!)

            senderRegister.text = "\(viewModel.transferDetails.sender.documentType) \(documentFormatted)"
        }

        if let senderAgencyAccount = transferDetailsView.senderAccountInformationStackView.arrangedSubviews[1] as? UILabel {
            senderAgencyAccount.text = viewModel.transferDetails.sender.bankName
        }
        if let senderAccount = transferDetailsView.senderAccountInformationStackView.arrangedSubviews[2] as? UILabel {
            let agency = viewModel.transferDetails.sender.agencyNumber
            let account = viewModel.transferDetails.sender.accountNumber

            senderAccount.text = formatAccount(agency, account)
        }

        // MARK: recipientStackView

        if let recipientNameAccount = transferDetailsView.recipientStackView.arrangedSubviews[1] as? UILabel {
            recipientNameAccount.text = String(viewModel.transferDetails.recipient.name)
        }
        if let recipientRegister = transferDetailsView.recipientAccountInformationStackView.arrangedSubviews[0] as? UILabel {
            let documentType = viewModel.getDocumentType(document: viewModel.transferDetails.recipient.documentType)
            let documentFormatted = documentFormatter(viewModel.transferDetails.recipient.documentNumber,
                                                      type: documentType!)

            recipientRegister.text = "\(viewModel.transferDetails.recipient.documentType) \(documentFormatted)"
        }
        if let recipientAgencyAccount = transferDetailsView.recipientAccountInformationStackView.arrangedSubviews[1] as? UILabel {
            recipientAgencyAccount.text = viewModel.transferDetails.recipient.bankName
        }
        if let recipientAccount = transferDetailsView.recipientAccountInformationStackView.arrangedSubviews[2] as? UILabel {
            let agency = viewModel.transferDetails.recipient.agencyNumber
            let account = viewModel.transferDetails.recipient.accountNumber

            recipientAccount.text = formatAccount(agency, account)
        }
    }

    func navigationBarAppearance() {
        navigationItem.title = constants.navigationTitle
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
}
