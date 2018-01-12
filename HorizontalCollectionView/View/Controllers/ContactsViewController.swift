//
//  ViewController.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 10/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, FavouriteContactProtocol, UISearchBarDelegate{
    
    var contactsArray = [VoicelynContact]()
    var filteredContacts = [VoicelynContact]()
    
    let contactCellId = "contactCellId"
    let contactCellIdWithPhoto = "contactCellIdWithPhoto"
    let favouriteBarId = "favouriteBarId"
    var searchBarBottomAnchor: NSLayoutConstraint?
    var searchBarTopAnchor: NSLayoutConstraint?
    var searchBarLeftAnchor: NSLayoutConstraint?
    var searchBarRightAnchor: NSLayoutConstraint?
    var navBar: UINavigationBar?
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.barTintColor = .gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        sb.placeholder = "Enter text here..."
        sb.delegate = self
        return sb
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        
        setupNavBar()
        fetchContacts()
        
        collectionView?.delegate = self
        collectionView?.alwaysBounceVertical = true
        collectionView?.keyboardDismissMode = .onDrag
        
        collectionView?.register(ContactCell.self, forCellWithReuseIdentifier: contactCellId)
        collectionView?.register(ContactCellWithPhoto.self, forCellWithReuseIdentifier: contactCellIdWithPhoto)
        collectionView?.register(FavouritesBar.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: favouriteBarId)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Contacts"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleSearchContacts))
        guard let navBar = navigationController?.navigationBar else {return}
        navBar.addSubview(searchBar)
//        searchBar.anchor(top: nil, left: navBar.leftAnchor, bottom: nil, right: navBar.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
//
//        searchBarTopAnchor = searchBar.topAnchor.constraint(equalTo: navBar.topAnchor)
//        searchBarTopAnchor?.isActive = true
//        searchBarBottomAnchor = searchBar.heightAnchor.constraint(equalTo: 0)
//        searchBarBottomAnchor?.isActive = true
        
        
        searchBarTopAnchor = searchBar.topAnchor.constraint(equalTo: navBar.topAnchor)
        searchBarTopAnchor?.isActive = true
        searchBarBottomAnchor = searchBar.bottomAnchor.constraint(equalTo: navBar.bottomAnchor)
        searchBarLeftAnchor = searchBar.leftAnchor.constraint(equalTo: navBar.leftAnchor, constant: 8)
        searchBarRightAnchor = searchBar.rightAnchor.constraint(equalTo: navBar.rightAnchor, constant: -8)
    }
    
    @objc func handleSearchContacts() {
        print("searching...")
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.searchBar.isHidden = false
            NSLayoutConstraint.activate([self.searchBarBottomAnchor!, self.searchBarLeftAnchor!, self.searchBarRightAnchor!])
            self.view.layoutIfNeeded()
        }, completion: { (finished) in
            self.searchBar.becomeFirstResponder()
        })
    }
    
    fileprivate func fetchContacts() {
        
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
            if granted {
                print("Access granted!")
                self.contactsArray = [VoicelynContact]()
                
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, failedPointer) in
                        self.contactsArray.append(VoicelynContact(contact: contact))
                    })
                    self.contactsArray = self.contactsArray.sorted{$0.name < $1.name}
                    self.filteredContacts = self.contactsArray
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
                catch let err {
                    print("Error fetching contacts: ", err)
                }
            }
            else {
                print("Access denied")
                return
            }
        }
    }
    
    //MARK: - FavoriteContactProtocol Delegate
    func handleTappingContact(cell: BaseCell) {
        guard let cell = cell as? ContactCellWithPhoto else {return}
        guard let cellIndexPath = collectionView?.indexPath(for: cell) else {return}
        let contactTapped = contactsArray[cellIndexPath.row]
        let isFavourited = contactTapped.isFavourited
        contactsArray[cellIndexPath.row].isFavourited = !isFavourited
        filteredContacts[cellIndexPath.row].isFavourited = !isFavourited
        print("Favorito carregado na posicao: ", cellIndexPath.item)

        cell.starButton.tintColor = isFavourited ? UIColor.rgb(red: 225, green: 225, blue: 225) : UIColor.rgb(red: 255, green: 206, blue: 27) 
//        DispatchQueue.main.async {
//            self.collectionView?.reloadData()
//        }
    }
    
    func handleTappingFavourite(cell: BaseCell) {
        print("handle tapping no controller para o favorite...")
    }
    
    //MARK: - CollectionView Delegate / Datasource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contactCellId, for: indexPath) as! ContactCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contactCellIdWithPhoto, for: indexPath) as! ContactCellWithPhoto
        cell.contact = filteredContacts[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 140)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: favouriteBarId, for: indexPath) as! FavouritesBar

        return header
    }
    
    
    override func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("SCROLL")
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        searchBarTextDidEndEditing(searchBar)
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
        
    }
    
    //MARK: - FlowLayoutDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //MARK: - SearchBar Delegate
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("Saiu do search")
//        searchBar.text = nil
        
        if searchBar.text == "" && !searchBar.isFirstResponder {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.searchBar.isHidden = true
                self.view.layoutSubviews()
            }, completion: {finished in
                self.searchBar.resignFirstResponder()
            })
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        if searchText.isEmpty {
            filteredContacts = contactsArray
            searchBarTextDidEndEditing(searchBar)
        }
        else {
            filteredContacts = contactsArray.filter { contact in contact.name.lowercased().contains(searchText.lowercased())}
        }
        self.collectionView?.reloadData()
    }
}

