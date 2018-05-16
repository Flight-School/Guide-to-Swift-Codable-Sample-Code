import UIKit

public class OrderSelectionViewController : UIViewController {
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        return pickerView
    }()
    
    lazy var peanutsLineItemView = LineItemView()
    lazy var crackersLineItemView = LineItemView()
    lazy var popcornLineItemView = LineItemView()

    lazy var saveButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Save Purchase", for: .normal)
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        stackView.addArrangedSubview(self.pickerView)
        stackView.addArrangedSubview(self.peanutsLineItemView)
        stackView.addArrangedSubview(self.crackersLineItemView)
        stackView.addArrangedSubview(self.popcornLineItemView)
        stackView.addArrangedSubview(self.saveButton)
        
        return stackView
    }()
    
    public override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        self.view.addSubview(self.stackView)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "In-Flight Snacks"
        
        self.peanutsLineItemView.item = "Peanuts"
        self.crackersLineItemView.item = "Crackers"
        self.popcornLineItemView.item = "Popcorn"
    }
    
    @IBAction
    func save() {
        var orders: [Order]
        let decoder = PropertyListDecoder()
        if let data = UserDefaults.standard.value(forKey: "orders") as? Data,
            let savedOrders = try? decoder.decode([Order].self, from: data) {
            orders = savedOrders
        } else {
            orders = []
        }
        
        let order = Order(seat: self.selectedSeat, itemCounts: [
            .peanuts: self.peanutsLineItemView.quantity,
            .crackers: self.crackersLineItemView.quantity,
            .popcorn: self.popcornLineItemView.quantity
        ])
        
        orders.append(order)
        
        let encoder = PropertyListEncoder()
        
        UserDefaults.standard.set(try? encoder.encode(orders), forKey: "orders")
        
        self.crackersLineItemView.quantity = 0
        self.peanutsLineItemView.quantity = 0
    }
}

extension OrderSelectionViewController {
    private enum PickerViewComponent: Int {
        case label
        case number
        case letter
    }
    
    var numbers: [Int] {
        return [6, 7, 8, 9, 10]
    }
    
    var letters: [String] {
        return ["A", "B", "C", "D", "E", "F"]
    }
    
    var selectedSeat: String {
        let selectedNumber = numbers[self.pickerView.selectedRow(inComponent: PickerViewComponent.number.rawValue)]
        let selectedLetter = letters[self.pickerView.selectedRow(inComponent: PickerViewComponent.letter.rawValue)]
        return "\(selectedNumber)\(selectedLetter)"
    }
}

extension OrderSelectionViewController: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch PickerViewComponent(rawValue: component)! {
        case .label:
            return 1
        case .number:
            return numbers.count
        case .letter:
            return letters.count
        }
    }
}

extension OrderSelectionViewController: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch PickerViewComponent(rawValue: component)! {
        case .label:
            return "Seat"
        case .number:
            return "\(numbers[row])"
        case .letter:
            return letters[row]
        }
    }
}
