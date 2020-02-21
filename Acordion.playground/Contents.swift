import UIKit
import PlaygroundSupport

protocol AccordionHeaderLoadable: UIView {
    var onDidTap: (() -> ())! { get set }
}
protocol AccordionViewLoadable: UIView {}
protocol AcordionView: UIView {
    associatedtype P: AccordionHeaderLoadable
    associatedtype T: AccordionViewLoadable
    var accordionHeader: P! { get set }
    var view: T! { get set }
    
    func didTapAccordion()
}

extension AcordionView {
    func initAcordion() {
        accordionHeader = P(frame: .zero)
        accordionHeader.onDidTap = didTapAccordion
        
        view = T(frame: .zero)
        let stackview = UIStackView(arrangedSubviews: [accordionHeader, view])
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackview)
        stackview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func didTapAccordion() {
        view.isHidden = !view.isHidden
    }
}




class TestHeaderView: UIView, AccordionHeaderLoadable {
    var onDidTap: (() -> ())!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTap() {
        onDidTap()
    }
}

class TestView: UIView, AccordionViewLoadable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func miau() {
        print("miau")
    }
}



class ProgressListAcordionView: UIView, AcordionView {
    var accordionHeader: TestHeaderView!
    var view: TestView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initAcordion()
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        accordionHeader.backgroundColor = .red
        view.backgroundColor = .green
    }
    
    func didTapAccordion() {
        view.miau()
    }
}

let view = ProgressListAcordionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
PlaygroundPage.current.liveView = view
