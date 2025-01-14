//
//  ImageDetailViewController.swift
//  PlaceBook
//
//  Created by 김건우 on 1/14/25.
//

import UIKit

final class ImageDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var item: Item? {
        didSet { update() }
    }
    
    // MARK: - Views
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInsetAdjustmentBehavior = .never
        return scroll
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.numberOfLines = 1
        title.font = .boldSystemFont(ofSize: 24)
        title.textColor = .white
        title.textAlignment = .left
        return title
    }()
    
    let textView: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.isSelectable = false
        text.isScrollEnabled = false
        text.allowsEditingTextAttributes = false
        text.font = .systemFont(ofSize: 18)
        return text
    }()
    
    let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        return stack
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(tappedCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewHierarchy()
        setupAttributes()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        scrollView.addSubview(closeButton)
        contentStack.addArrangedSubview(imageView)
        contentStack.addArrangedSubview(textView)
        imageView.addSubview(titleLabel)
    }
    
    private func setupAttributes() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            closeButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10)
        ])
    }
    
    
    // MARK: - Private
    
    private func update() {
        imageView.image = UIImage(named: item!.image)
        titleLabel.text = item?.title
        textView.text = item?.description
    }
    
    @objc private func tappedCloseButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
