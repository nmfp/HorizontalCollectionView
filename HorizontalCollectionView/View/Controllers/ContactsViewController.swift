//
//  ViewController.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 10/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FavouriteContactProtocol, UISearchBarDelegate{
    
    var contactsArray = [VoicelynContact]()
    var filteredContactsArray = [VoicelynContact]()
    var favouritesArray = [VoicelynContact]()
    
    let contactCellId = "contactCellId"
    let contactCellIdWithPhoto = "contactCellIdWithPhoto"
    let favouriteBarId = "favouriteBarId"
    var searchBarBottomAnchor: NSLayoutConstraint?
    var searchBarTopAnchor: NSLayoutConstraint?
    var searchBarLeftAnchor: NSLayoutConstraint?
    var searchBarRightAnchor: NSLayoutConstraint?
    var navBar: UINavigationBar?
    
    var favouritesBarHeight: NSLayoutConstraint?
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.barTintColor = .gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        sb.placeholder = "Enter text here..."
        sb.delegate = self
        return sb
    }()
    
    lazy var favouritesBar: FavouritesBar = {
        let view = FavouritesBar()
        view.backgroundColor = .green
        view.delegate = self
        return view
    }()
    
    lazy var contactsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var chooseNumberToCallView: ChooseNumberToCall = {
        let view = ChooseNumberToCall()
        view.contactsViewController = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNavBar()
        setupFavouritesBar()
        fetchContacts()
        //Quando uma ViewController tem uma ScrollView, esta tem a intencao de ajustar o contentInsect desta
        //para ter em canta a altura da statusBar e da navigationBar, e para evitar isso define-se esta propriedade
        //a false para indicar que o contentInsect e gerido pelo programador.
        //No iOS11 nao foi necessario fazer isto mas para o iOS10 as celulas apareciam muito abaixo do topo da collectionView
        self.automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(contactsCollectionView)
        contactsCollectionView.backgroundColor = .white
        
        contactsCollectionView.anchor(top: favouritesBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        contactsCollectionView.alwaysBounceVertical = true
        contactsCollectionView.keyboardDismissMode = .onDrag
        
        contactsCollectionView.register(ContactCell.self, forCellWithReuseIdentifier: contactCellId)
        contactsCollectionView.register(ContactCellWithPhoto.self, forCellWithReuseIdentifier: contactCellIdWithPhoto)
        contactsCollectionView.register(FavouritesBar.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: favouriteBarId)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    fileprivate func setupFavouritesBar() {
        view.addSubview(favouritesBar)
        favouritesBar.anchor(top: self.topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        favouritesBarHeight = favouritesBar.heightAnchor.constraint(equalToConstant: 142)
        favouritesBarHeight?.isActive = true
        favouritesBarHeight?.constant = 0
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Contacts"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleSearchContacts))
        guard let navBar = navigationController?.navigationBar else {return}
        navBar.addSubview(searchBar)
        
        searchBarTopAnchor = searchBar.topAnchor.constraint(equalTo: navBar.topAnchor)
        searchBarTopAnchor?.isActive = true
        searchBarBottomAnchor = searchBar.bottomAnchor.constraint(equalTo: navBar.bottomAnchor)
        searchBarLeftAnchor = searchBar.leftAnchor.constraint(equalTo: navBar.leftAnchor, constant: 8)
        searchBarRightAnchor = searchBar.rightAnchor.constraint(equalTo: navBar.rightAnchor, constant: -8)
    }
    
    @objc func handleSearchContacts() {
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
                    self.filteredContactsArray = self.contactsArray
                    DispatchQueue.main.async {
                        self.contactsCollectionView.reloadData()
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
    
    fileprivate func animateFavouritesBar() {
        if favouritesArray.count > 0 {
            favouritesBarHeight?.isActive = false
            favouritesBarHeight?.constant = 140
            favouritesBarHeight?.isActive = true
        }
        else {
            favouritesBarHeight?.isActive = false
            favouritesBarHeight?.constant = 0
            favouritesBarHeight?.isActive = true
        }
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    //MARK: - FavoriteContactProtocol Delegate
    func handleTappingContact(cell: BaseCell) {
        guard let cell = cell as? ContactCellWithPhoto else {return}
        guard let cellIndexPath = contactsCollectionView.indexPath(for: cell) else {return}
        let contactTapped = filteredContactsArray[cellIndexPath.item]
        let isFavourited = contactTapped.isFavourited
        
        let index = contactsArray.index {$0.uuid == contactTapped.uuid}
        guard let contactIndex = index else {return}
        
        filteredContactsArray[cellIndexPath.row].isFavourited = !isFavourited
        contactsArray[contactIndex].isFavourited = !isFavourited

        cell.starButton.tintColor = isFavourited ? UIColor.rgb(red: 225, green: 225, blue: 225) : UIColor.rgb(red: 255, green: 206, blue: 27) 

        if !isFavourited {
            favouritesArray.append(contactTapped)
        }
        else {
            favouritesArray = favouritesArray.filter {$0.uuid != contactTapped.uuid}
        }
        self.favouritesBar.favourites = self.favouritesArray
        animateFavouritesBar()
    }
    
    func handleTappingFavourite(cell: BaseCell) {
        print("handle tapping no controller para o favorite...")
        guard let indexPath = favouritesBar.collectionView.indexPath(for: cell) else {return}
        let favourite = favouritesArray[indexPath.item]
        chooseNumberToCallView.contact = favourite
        chooseNumberToCallView.showNumbersToCallView()
    }
    
    //MARK: - CollectionView Delegate / Datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredContactsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contactCellIdWithPhoto, for: indexPath) as! ContactCellWithPhoto
        cell.contact = filteredContactsArray[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        searchBarTextDidEndEditing(searchBar)
    }
    
    //MARK: - FlowLayoutDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //MARK: - SearchBar Delegate
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
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
        if searchText.isEmpty {
            filteredContactsArray = contactsArray
            searchBarTextDidEndEditing(searchBar)
        }
        else {
            filteredContactsArray = contactsArray.filter { contact in contact.name.lowercased().contains(searchText.lowercased())}
        }
        self.contactsCollectionView.reloadData()
    }
}

