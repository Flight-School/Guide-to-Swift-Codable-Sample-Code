import UIKit

@objc
public class LineItemView: UIView {
    public var item: String? = nil {
        didSet {
            self.itemNameLabel.text = self.item
            self.quantity = 0
        }
    }
    
    public var quantity: Int = 0 {
        didSet {
            self.itemQuantityLabel.text = "\(self.quantity)"
        }
    }
    
    lazy var itemNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = self.item
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var quantityStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 0
        stepper.stepValue = 1
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        stepper.addTarget(self, action: #selector(updateQuantity), for: .valueChanged)
        
        return stepper
    }()
    
    lazy var itemQuantityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: self.bounds)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        stackView.addArrangedSubview(self.itemNameLabel)
        stackView.addArrangedSubview(self.quantityStepper)
        stackView.addArrangedSubview(self.itemQuantityLabel)
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        self.addSubview(self.stackView)
    }
    
    @IBAction
    func updateQuantity() {
        self.quantity = Int(self.quantityStepper.value)
    }
    
    public required init(coder: NSCoder) {
        fatalError("Not Implemented")
    }
}
